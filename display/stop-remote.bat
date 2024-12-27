@echo off
@REM MultiMonitorTool.exe /enable SAM7115
@REM MultiMonitorTool.exe /enable BOE08B3
MultiMonitorTool.exe /SetMonitors "Name=MONITOR\SAM7115\{4d36e96e-e325-11ce-bfc1-08002be10318}\0001 BitsPerPixel=32 Width=1920 Height=1080 DisplayFlags=0 DisplayFrequency=60 DisplayOrientation=0 PositionX=1920 PositionY=0" "Name=MONITOR\BOE08B3\{4d36e96e-e325-11ce-bfc1-08002be10318}\0000 Primary=1 BitsPerPixel=32 Width=1920 Height=1080 DisplayFlags=0 DisplayFrequency=144 DisplayOrientation=0 PositionX=0 PositionY=0"
MultiMonitorTool.exe /disable "MONITOR\MTT1337\{4d36e96e-e325-11ce-bfc1-08002be10318}\0004"
MultiMonitorTool.exe /disable "MONITOR\MTT1337\{4d36e96e-e325-11ce-bfc1-08002be10318}\0003"
MultiMonitorTool.exe /loadconfig default.cfg
