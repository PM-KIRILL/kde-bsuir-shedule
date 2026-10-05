import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("Основное")
        icon: "view-calendar"
        source: "config/ConfigGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Внешний вид и цвета")
        icon: "preferences-desktop-color"
        source: "config/ConfigAppearance.qml"
    }
}
