#!/usr/bin/env bash
set -e

PLASMOID_ID="org.kde.plasma.bsuirschedule"
TARGET_DIR="${HOME}/.local/share/plasma/plasmoids/${PLASMOID_ID}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Установка виджета ${PLASMOID_ID} ==="

mkdir -p "${HOME}/.local/share/plasma/plasmoids"

if [ "$1" == "--symlink" ] || [ "$1" == "-s" ]; then
    echo "-> Создание символической ссылки: ${SCRIPT_DIR} -> ${TARGET_DIR}"
    rm -rf "${TARGET_DIR}"
    ln -s "${SCRIPT_DIR}" "${TARGET_DIR}"
else
    echo "-> Копирование файлов в ${TARGET_DIR}"
    rm -rf "${TARGET_DIR}"
    mkdir -p "${TARGET_DIR}"
    cp -r "${SCRIPT_DIR}/metadata.json" "${TARGET_DIR}/"
    cp -r "${SCRIPT_DIR}/contents" "${TARGET_DIR}/"
fi

if command -v kpackagetool6 &> /dev/null; then
    echo "-> Обновление кэша плагинов KDE..."
    kpackagetool6 --type Plasma/Applet --upgrade "${TARGET_DIR}" 2>/dev/null || true
fi

echo ""
echo "Установка успешно завершена!"
echo "Теперь вы можете добавить виджет на рабочий стол или панель KDE Plasma:"
echo "1. Правый клик по рабочему столу/панели -> 'Добавить виджеты...'"
echo "2. Найти 'Расписание БГУИР' (BSUIR Schedule)"
echo ""
echo "Для мгновенного тестирования в окне выполните:"
echo "plasmawindowed ${PLASMOID_ID}"
