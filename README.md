Author: Hrytsyna Anton, Group: TTP-32

# Лабораторна №2: профілювання та оптимізація програми

У роботі порівнюю три збірки однієї програми C++17: `O0`, `O3 scalar` без автоматичної векторизації та `O3` з AVX2. Програма створює RGB-дані в пам’яті, переводить їх у відтінки сірого, змінює контраст і виконує розмиття. Дані та кількість повторень однакові; правильність перевіряється тестами й контрольною сумою.

## Код

- Програма: [main.cpp](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/src/main.cpp), [kernels.cpp](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/src/kernels.cpp), [kernels.hpp](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/src/kernels.hpp).
- Команди демонстрації: [defense.py](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/scripts/linux/defense.py).
- Збирання та ключі компілятора: [Makefile](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/Makefile).
- Асемблер, згенерований GCC: [O0](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/results/assembly/kernels_o0.s), [O3 scalar](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/results/assembly/kernels_scalar.s), [O3 AVX2](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/results/assembly/kernels_o3.s).
- Вимірювання енергії: [run_sync_energy_series.ps1](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/scripts/windows/run_sync_energy_series.ps1), [Measure-SynchronizedEnergy.ps1](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/scripts/windows/Measure-SynchronizedEnergy.ps1).

## Запуск

Працюю в Ubuntu 24.04 через WSL2. Потрібні GCC з підтримкою AVX2, make, Python 3, GNU time, perf та Perl; для читання Windows EMI — PowerShell 7.

Із папки проєкту в терміналі Ubuntu:

```bash
make -j2 ARCH_FLAGS=-mavx2
alias lab='python3 scripts/linux/defense.py'
lab prepare
lab asm
lab stats
lab record
lab report
lab results
lab flame
lab open
lab energy
lab energy-results
```

`lab` — звичайний Bash-аліас для запуску `defense.py`. Скрипт показує команди й виконує їх через `subprocess`: `stats` запускає time та perf stat, `record` записує профілі, `report` аналізує їх, а `flame` перетворює ті самі записи на SVG. Коротка демонстрація має 100 повторень; основні збережені вимірювання — 300.

## Результати

Навантаження: 2048×2048, 300 повторень, seed 12345. У таблиці — медіани п’яти вимірювань часу та трьох вимірювань енергії на збірку.

| Збірка | Час обчислень, с | Енергія PKG, Дж | Оцінка внеску програми в PKG, Дж |
|---|---:|---:|---:|
| O0 | 15,85 | 486,97 | 239,13 |
| O3 scalar | 6,05 | 188,85 | 69,60 |
| O3 | 2,89 | 99,27 | 57,54 |

O3 виконав ту саму роботу приблизно у 5,48 раза швидше. Енергія процесорного пакета зменшилася приблизно на 80%.

Через EMI вимірюю енергію процесорного пакета PKG та пам’яті DRAM. Внесок програми оцінюю як `E_active − P_idle × T_active`. Це оцінка після віднімання фону, а не прямий лічильник процесу чи вимірювання всього ПК з розетки.

Сирі дані: [time, perf і FlameGraph](https://github.com/quadroex/os-lab2-performance-image-pipeline/tree/main/results/linux-main), [енергія PKG/DRAM](https://github.com/quadroex/os-lab2-performance-image-pipeline/tree/main/results/energy-sync-host-20261023T195827031Z). Походження інструментів і матеріалів наведено в [джерелах](https://github.com/quadroex/os-lab2-performance-image-pipeline/blob/main/docs/SOURCES.md).

Під час підготовки коду, навчання та для кращого розуміння теми я використовував штучний інтелект (Codex). Підтверджую, що опанував тему лабораторної роботи й можу пояснити код, виконані вимірювання та отримані результати.
