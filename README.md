# Dex2C setup (hiwalay sa DPT Dumper)

[Dex2C](https://github.com/codehasan/dex2c) converts chosen DEX methods into
native C/C++ (JNI) so they are much harder to read with jadx/apktool. It is
the opposite of DPT Dumper: DPT Dumper restores DEX, dex2c hides it.

Hiwalay na proyekto ito kaya hindi nasisira ang DPT Dumper app.

## Option A — sa Termux mismo

```bash
bash termux_setup.sh
```

Kapag tapos na (mga 10-15 min, may NDK download), ilagay ang APK mo sa
`~/dex2c/` at:

```bash
cd ~/dex2c
python3 dcc.py your.apk
```

Lalabas ang `your_unsigned.apk` (o kahalintulad) sa parehong folder — kailangan mo pang i-sign bago ito ma-install.
Signing:

```bash
~/dex2c/tools/apksigner sign --ks your.keystore --out signed.apk your_unsigned.apk
```

(Gamitin ang parehong keystore/password na ginagamit mo sa David2K Tool, kung meron ka na.)

## Option B — GitHub Actions (kapag kulang ang storage/battery sa phone)

1. Ilagay ang APK sa `apk_in/` sa repo mong ito, i-commit, i-push.
2. GitHub, Actions, **Dex2C Protect APK**, **Run workflow**, ilagay ang
   eksaktong pangalan ng file sa `apk_name`.
3. Hintayin (10-20 min — malaki ang NDK download + native compile).
4. Kunin ang `dex2c-protected-apk` sa Artifacts. Kailangan mo pa ring i-sign
   ito bago i-install.

## Pagpili ng mga method (filters/filter.txt)

Default: dex2c mismo lang ang nagde-decide (Activity.onCreate + demo
methods). Para pumili ka mismo, lagyan ng regex ang `filters/filter.txt`,
hal.:

```
com\.david2k\.dptdumper\..*->.*\(.*\)
```

Mag-ingat: habang mas marami kang method na i-native, mas mabagal ang
compile at mas malaki ang panganib ng bug — simulan sa isa o dalawang method
muna, subukan, bago dagdagan.

## Bakit hiwalay sa DPT Dumper

Dex2C ay nangangailangan ng buong Android NDK, apktool at Python
toolchain — hindi ito kasya sa isang maliit na Android app na parang DPT
Dumper. Mas tama na PC-style na proyekto ito (o GitHub Actions), hindi isang
button sa app.
