@echo off
MultiMonitorTool.exe /disable BOE08B3
MultiMonitorTool.exe /disable SAM7115
@REM MultiMonitorTool.exe /enable "MONITOR\MTT1337\{4d36e96e-e325-11ce-bfc1-08002be10318}\0003"
@REM MultiMonitorTool.exe /enable "MONITOR\MTT1337\{4d36e96e-e325-11ce-bfc1-08002be10318}\0004"
MultiMonitorTool.exe /SetMonitors "Name=MONITOR\MTT1337\{4d36e96e-e325-11ce-bfc1-08002be10318}\0003 Primary=1 BitsPerPixel=32 Width=1920 Height=1080 DisplayFlags=0 DisplayFrequency=60 DisplayOrientation=0 PositionX=0 PositionY=0" "Name=MONITOR\MTT1337\{4d36e96e-e325-11ce-bfc1-08002be10318}\0004 BitsPerPixel=32 Width=1920 Height=1080 DisplayFlags=0 DisplayFrequency=60 DisplayOrientation=0 PositionX=1920 PositionY=0"

