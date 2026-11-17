#!/bin/sh
# NetzTopo portable – Linux (und macOS mit vorhandenem python3)
D="$(cd "$(dirname "$0")" && pwd)"
export NETZTOPO_HOME="$D/Daten" PYTHONNOUSERSITE=1
PY=""
case "$(uname -s)-$(uname -m)" in
  Linux-x86_64|Linux-amd64) PY="$D/runtime/linux64/bin/python3.8" ;;
esac
if [ -n "$PY" ] && [ ! -x "$PY" ]; then chmod +x "$PY" 2>/dev/null; fi
if [ -z "$PY" ] || ! "$PY" -c "import sys" >/dev/null 2>&1; then
  # USB-Stick evtl. mit 'noexec' eingehängt oder andere Plattform -> System-Python verwenden
  PY="$(command -v python3 || true)"
  if [ -z "$PY" ]; then echo "Kein Python gefunden. Bitte python3 installieren oder den Stick mit exec einhängen."; exit 1; fi
  echo "Hinweis: verwende System-Python ($PY)"
fi
exec "$PY" "$D/app/netztopo.py" "$@"
