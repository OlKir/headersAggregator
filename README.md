# Headers Aggregator

Command line tool that scans folder structure for .h files, copies them to selected folder and creates list of them. Useful for creation xcframeworks from Obj-C code.

## Usage
```
./headersAggregator <inputPath> <outputPath> [headers list file name]
```

Parameters are set without names or keys:
<inputPath> path to the root of folder structure to scan
<outputPath> path where to copy headers
[headers list file name] optional, name of the file with list of headers. "umbrella_header.h" by default.
