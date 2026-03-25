WindNinja
=========
<!---[![example workflow](https://github.com/firelab/windninja/actions/workflows/testing.yml/badge.svg)](https://github.com/firelab/windninja/actions)--->
[![DOI](https://zenodo.org/badge/21244/firelab/windninja.svg)](https://zenodo.org/badge/latestdoi/21244/firelab/windninja)

Uso Rápido (CLI)
================

## Estructura de Carpetas

```
windninja/
├── build/          # Todo lo necesario para ejecutar
│   ├── input/      # DEM de entrada (modelo digital de elevación)
│   │   ├── dem.asc
│   │   └── dem.prj
│   ├── output/     # Resultados de la simulación
│   ├── config.cfg  # Configuración de la simulación
│   └── src/cli/WindNinja_cli  # Ejecutable
└── src/           # Código fuente
```

## Configuración (config.cfg)

Los parámetros principales están en `build/config.cfg`:

```ini
# ===== VIENTO =====
# Velocidad del viento
input_speed = 30
input_speed_units = kph          # opciones: kph, mph, mps, kts

# Dirección del viento (desde dónde viene)
# 0 = Norte, 90 = Este, 180 = Sur, 270 = Oeste, 315 = Noroeste
input_direction = 315

# ===== VEGETACIÓN =====
# Tipo de cobertura de suelo
vegetation = trees               # opciones: grass, brush, trees

# ===== RESOLUCIÓN =====
mesh_resolution = 30             # 30m, 100m, etc.
units_mesh_resolution = m

# ===== SALIDAS =====
write_ascii_output = 1           # 1 = generar .asc (velocidad, dirección, nubes)
write_goog_output = 0            # 1 = generar .kmz (Google Earth)
write_shapefile_output = 0       # 1 = generar .shp

# Carpeta de salida
output_path = ./output/
```

> **Valores por defecto para la Patagonia (Noroeste):**
> - Velocidad: 30 kph
> - Dirección: 315° (desde el noroeste)
> - Vegetación: trees (árboles)

## Ejecutar la Simulación

```bash
# 1. Crear carpeta output (si no existe)
mkdir -p build/output

# 2. Ejecutar el simulador
cd build
./src/cli/WindNinja_cli --config_file config.cfg
```

## Archivos de Salida

Los resultados se generan en `build/output/`:

| Archivo | Descripción |
|---------|-------------|
| `*_vel.asc` | Velocidad del viento |
| `*_ang.asc` | Dirección del viento |
| `*_cld.asc` | Cobertura de nubes |
| `*.shp` | Shapefile con velocidad y dirección |
| `*.kmz` | Visualización en Google Earth |

---



# WindNinja is a diagnostic wind model developed for use in wildland fire modeling.

Web:
https://ninjastorm.firelab.org/windninja/

Source & wiki:
https://github.com/firelab/windninja

FAQ:
[https://ninjastorm.firelab.org/windninja/faq.html](https://ninjastorm.firelab.org/windninja/faq.html)

Install: https://github.com/firelab/windninja/wiki

Directories:
 * autotest    -> testing suite
 * cmake       -> cmake support scripts
 * data        -> testing data
 * doc         -> documentation
 * images      -> splash image and icons for gui
 * src         -> source files

Dependencies (versions are versions we build against for the Windows installer):
 * Boost 1.46:
    * boost_date_time
    * boost_program_options
    * boost_test
 * NetCDF 4.1.1
 * GDAL 2.2.2
    * NetCDF support
    * PROJ.4 support
    * GEOS support
    * CURL support
 * Qt 4.8.5
    * QtGui
    * QtCore
    * QtNetwork/Phonon
    * QtWebKit
 * [OpenFOAM 2.2.x](https://github.com/OpenFOAM/OpenFOAM-2.2.x)

See INSTALL for more information (coming soon)

See CREDITS for authors

See NEWS for release information

Example Output
===
<img src="images/bsb.jpg" alt="Example output"  />

