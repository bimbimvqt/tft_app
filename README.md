## 📊 Sơ đồ Query Flow cho Gold Screen và Currency Screen

### 🏗️ **Kiến trúc tổng quan:**

```
┌─────────────────────────────────────────────────────────────────┐
│                        UI Layer (Screens)                        │
├─────────────────────────────────────────────────────────────────┤
│  GoldScreen                    │  CurrencyScreen                │
│  - TabController              │  - TabController               │
│  - Brand selection            │  - Bank selection              │
│  - Location filtering          │  - Currency filtering          │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Controller Layer (GetX)                       │
├─────────────────────────────────────────────────────────────────┤
│  GoldController                │  CurrencyController             │
│  - State management            │  - State management            │
│  - Cache management            │  - Cache management            │
│  - Data processing             │  - Data processing             │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Service Layer                               │
├─────────────────────────────────────────────────────────────────┤
│  GoldPriceService              │  ExchangeRateService           │
│  - Business logic              │  - Business logic              │
│  - Cache strategy              │  - Cache strategy              │
│  - Data validation             │  - Data validation             │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Repository Layer                              │
├─────────────────────────────────────────────────────────────────┤
│  GoldPriceRepository           │  ExchangeRateRepository        │
│  BrandRepository               │  CurrencyRepository             │
│  LocationRepository            │  BankRepository                 │
│  GoldPricesAvgRepository      │  CurrencyRateRepository         │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Database Layer (Supabase)                    │
├─────────────────────────────────────────────────────────────────┤
│  Tables:                       │  Tables:                       │
│  - gold_prices                 │  - exchange_rates              │
│  - brands                      │  - currencies                  │
│  - locations                  │  - banks                       │
│  - gold_products              │  - gold_prices_avg            │
│  - config                     │                                │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔍 **Chi tiết Query Flow cho từng màn hình:**

### 📱 **1. GOLD SCREEN**

#### **A. Khởi tạo dữ liệu:**
```dart
// GoldController._initializeData()
await Future.wait([
  _loadBrands(),           // Query: SELECT * FROM brands ORDER BY name
  _loadLocations(),        // Query: SELECT * FROM locations ORDER BY name  
  _loadHomeGoldCards(),    // Query: SELECT * FROM gold_prices_avg WHERE product_id IN (...)
]);

await _goldPriceService.loadLatestPrices(); // Query: SELECT * FROM gold_prices WITH relations
```

#### **B. Query chính cho Gold Prices:**
```sql
-- GoldPriceRepository.getWithRelations()
SELECT 
  *,
  brand:brands!brand_id(id, name, display_name),
  gold_product:gold_products!product_id(id, name, display_name, purity),
  location:locations!location_id(id, name, display_name, region)
FROM gold_prices 
WHERE brand_id = ? 
ORDER BY created DESC 
LIMIT 50
```

#### **C. Query cho Home Cards:**
```sql
-- GoldPricesAvgRepository.getLatestTwoByProductId()
SELECT * FROM gold_prices_avg 
WHERE product_id = ? 
ORDER BY created DESC 
LIMIT 2
```

#### **D. Query cho Price Changes:**
```sql
-- GoldPriceRepository.getLatestTwoPrices()
SELECT * FROM gold_prices 
WHERE brand_id = ? AND product_id = ? 
ORDER BY created DESC 
LIMIT 2
```

---

### 💱 **2. CURRENCY SCREEN**

#### **A. Khởi tạo dữ liệu:**
```dart
// CurrencyController._initializeData()
final currencies = await _currencyRepository.getAllOrderedByCode(); // Query: SELECT * FROM currencies ORDER BY code
await _loadBanksFromDatabase(); // Query: SELECT DISTINCT bank_name FROM exchange_rates
await _loadRealExchangeRates(currencies); // Query: SELECT * FROM exchange_rates WITH relations
```

#### **B. Query chính cho Exchange Rates:**
```sql
-- ExchangeRateRepository.getLatestRates()
SELECT 
  *,
  bank:banks!bank_id(id, name, code, created_at)
FROM exchange_rates 
ORDER BY timestamp DESC, created_at DESC
```

#### **C. Query cho Rate Changes:**
```sql
-- ExchangeRateRepository.getSimpleLatestTwoRates()
SELECT * FROM exchange_rates 
WHERE bank_id = ? AND currency_code = ? 
ORDER BY created_at DESC 
LIMIT 20
```

#### **D. Query cho Bank-specific data:**
```sql
-- ExchangeRateRepository.getLatestRates(bankId)
SELECT * FROM exchange_rates 
WHERE bank_id = ? 
ORDER BY timestamp DESC, created_at DESC
```

---

## 🚀 **Cache Strategy:**

### **Gold Screen Cache:**
- **Cache Key:** `'gold_prices'`
- **TTL:** 30 phút
- **Fallback:** Cache → Database
- **Preload:** Tất cả brands trong background

### **Currency Screen Cache:**
- **Cache Key:** `'currency_rates'`
- **TTL:** 30 phút  
- **Fallback:** Cache → Database
- **Preload:** Rate changes cho tất cả banks

---

## 📋 **Tóm tắt Query Patterns:**

### **1. Gold Screen Queries:**
| Query Type | Table | Purpose | Relations |
|------------|-------|---------|-----------|
| `getWithRelations()` | `gold_prices` | Lấy giá vàng với thông tin brand, product, location | ✅ |
| `getLatestTwoByProductId()` | `gold_prices_avg` | Lấy 2 giá gần nhất cho home cards | ❌ |
| `getLatestTwoPrices()` | `gold_prices` | Tính price changes | ✅ |
| `getAllOrderedByName()` | `brands` | Lấy danh sách brands | ❌ |
| `getAllOrderedByName()` | `locations` | Lấy danh sách locations | ❌ |

### **2. Currency Screen Queries:**
| Query Type | Table | Purpose | Relations |
|------------|-------|---------|-----------|
| `getLatestRates()` | `exchange_rates` | Lấy tỷ giá mới nhất | ✅ |
| `getSimpleLatestTwoRates()` | `exchange_rates` | Tính rate changes | ✅ |
| `getAllOrderedByCode()` | `currencies` | Lấy danh sách currencies | ❌ |
| `getAllOrderedByName()` | `banks` | Lấy danh sách banks | ❌ |

---

## 🔧 **Đặc điểm kỹ thuật:**

### **1. Supabase Query Features được sử dụng:**
- **Relations:** `brand:brands!brand_id(...)`
- **Filtering:** `.eq()`, `.gte()`, `.lte()`
- **Ordering:** `.order()`
- **Pagination:** `.limit()`, `.range()`
- **Search:** `.ilike()`

### **2. Performance Optimizations:**
- **Cache-first strategy** với fallback
- **Background preloading** cho data không cần thiết ngay
- **Batch queries** với `Future.wait()`
- **Smart refresh** chỉ khi cache hết hạn

### **3. Error Handling:**
- **Graceful fallback** từ cache khi DB fail
- **Validation** trước khi cache data
- **Retry mechanism** cho failed queries
