<div align="center">

# 🔢 sevenSegment Decoder

**A BCD-to-7-segment decoder in VHDL with a self-checking testbench.**

[![VHDL](https://img.shields.io/badge/VHDL-IEEE%201164-543078?style=flat-square&label=VHDL&logo=vhd)](https://en.wikipedia.org/wiki/VHDL)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

</div>

---

## 🇬🇧 English

A combinational circuit from my digital-design coursework: it takes a 4-bit BCD digit (`A B C D`) and drives the seven segments (`a`–`g`) of a common-cathode display. Digits `0`–`9` render normally; invalid BCD inputs (`10`–`15`) **blank the display** instead of showing garbage — the safest default for a real front panel.

The repo was recently hardened:

- ports upgraded from legacy `bit` types to the industry-standard **`std_logic` / `std_logic_vector`**
- fixed a broken use clause (`use IEEE.std_logic_1164;` → `use IEEE.std_logic_1164.all;`)
- the decoder logic is now an explicit **`with … select`** table instead of a long conditional chain
- a ModelSim compiler artifact (`work-obj93.cf`) was removed from version control and `.gitignore` now covers simulator junk
- a **self-checking testbench** verifies all 16 input combinations

### 📐 Interface

```vhdl
entity sevenSegment is
    port (
        A, B, C, D : in  std_logic;             -- BCD digit, A = MSB
        seg        : out std_logic_vector(6 downto 0)  -- a b c d e f g (active-high)
    );
end sevenSegment;
```

### 🔢 Truth table

| BCD | Digit | `seg` (a b c d e f g) |
|:---:|:-----:|:----------------------|
| 0000 | **0** | `1111110` |
| 0001 | **1** | `0110000` |
| 0010 | **2** | `1101101` |
| 0011 | **3** | `1111001` |
| 0100 | **4** | `0110011` |
| 0101 | **5** | `1011011` |
| 0110 | **6** | `1011111` |
| 0111 | **7** | `1110000` |
| 1000 | **8** | `1111111` |
| 1001 | **9** | `1111011` |
| 1010–1111 | *(blank)* | `0000000` |

### 🧪 Simulate it

**ModelSim / QuestaSim:**

```tcl
vcom sevenSegment.vhd tb_sevenSegment.vhd
vsim tb_sevenSegment -c -do "run -all; quit"
```

**GHDL:**

```bash
ghdl -a sevenSegment.vhd tb_sevenSegment.vhd
ghdl -e tb_sevenSegment
ghdl -r tb_sevenSegment
```

The testbench prints `ALL TESTS PASSED (16/16)` when every pattern matches.

---

## 🇮🇷 فارسی

یک مدار ترکیبی از تمرین‌های درس طراحی دیجیتال: یک رقم BCD چهارت‌بیتی (`A B C D`) را می‌گیرد و هفت سگمنت نمایشگر (`a` تا `g`) را روشن می‌کند. ارقام `0` تا `9` به‌درستی نمایش داده می‌شوند و ورودی‌های BCD نامعتبر (`10` تا `15`) به‌جای نمایش نماد بی‌معنی، **نمایشگر را خاموش می‌کنند** — پیش‌فرض امن برای یک پنل واقعی.

این ریپو اخیراً بهینه و بازنویسی شده است:

- پورت‌ها از انواع قدیمی `bit` به استاندارد صنعتی **`std_logic` / `std_logic_vector`** ارتقا یافتند
- عبارت `use` ناقص اصلاح شد (`use IEEE.std_logic_1164;` → `use IEEE.std_logic_1164.all;`)
- منطق دیکدر به یک جدول صریح **`with … select`** تبدیل شد (به‌جای زنجیرهٔ شرط طولانی)
- فایل زبالهٔ کامپایلر ModelSim (`work-obj93.cf`) از گیت حذف شد و `.gitignore` برای فایل‌های شبیه‌ساز اضافه شد
- یک **تست‌بنچ خود-آزمایند** هر ۱۶ حالت ورودی را بررسی می‌کند

### 📐 رابط مدار

```vhdl
entity sevenSegment is
    port (
        A, B, C, D : in  std_logic;             -- رقم BCD، بیت A پرارزش است
        seg        : out std_logic_vector(6 downto 0)  -- a b c d e f g (فعال-بالا)
    );
end sevenSegment;
```

### 🧪 شبیه‌سازی

**ModelSim / QuestaSim:**

```tcl
vcom sevenSegment.vhd tb_sevenSegment.vhd
vsim tb_sevenSegment -c -do "run -all; quit"
```

**GHDL:**

```bash
ghdl -a sevenSegment.vhd tb_sevenSegment.vhd
ghdl -e tb_sevenSegment
ghdl -r tb_sevenSegment
```

در صورت موفقیت همهٔ الگوها، پیام `ALL TESTS PASSED (16/16)` چاپ می‌شود.

---

<div align="center">

**Maintained by [Parsa Fathi](https://github.com/ParsaFathii)**

</div>
