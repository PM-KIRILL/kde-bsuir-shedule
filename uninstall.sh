#!/usr/bin/env bash
set -e

PLASMOID_ID="org.kde.plasma.bsuirschedule"
TARGET_DIR="${HOME}/.local/share/plasma/plasmoids/${PLASMOID_ID}"

echo "=== Удаление виджета ${PLASMOID_ID} ==="

if [ -d "${TARGET_DIR}" ] || [ -L "${TARGET_DIR}" ]; then
    rm -rf "${TARGET_DIR}"
    echo "-> Директория ${TARGET_DIR} удалена."
else
    echo "-> Виджет не найден в ${TARGET_DIR}."
fi

if command -v kpackagetool6 &> /dev/null; then
    kpackagetool6 --type Plasma/Applet --remove "${PLASMOID_ID}" 2>/dev/null || true
fi

echo "Виджет успешно удален."
