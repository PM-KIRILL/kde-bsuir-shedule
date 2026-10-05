import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: configGeneral

    property alias cfg_groupNumber: groupField.text
    property alias cfg_subgroup: subgroupCombo.currentIndex
    property string cfg_language: langCombo.model[langCombo.currentIndex].code
    property int cfg_autoRefreshInterval: intervalCombo.model[intervalCombo.currentIndex].value
    property alias cfg_showPastLessons: pastCheck.checked

    Kirigami.FormLayout {
        QQC2.TextField {
            id: groupField
            Kirigami.FormData.label: i18n("Номер группы:")
            placeholderText: "например, 310101"
            Layout.fillWidth: true
        }

        QQC2.ComboBox {
            id: subgroupCombo
            Kirigami.FormData.label: i18n("Подгруппа:")
            model: [
                i18n("Все подгруппы"),
                i18n("1-я подгруппа"),
                i18n("2-я подгруппа")
            ]
            Layout.fillWidth: true
        }

        QQC2.ComboBox {
            id: langCombo
            Kirigami.FormData.label: i18n("Язык интерфейса:")
            textRole: "text"
            model: [
                { text: i18n("Авто (системный)"), code: "auto" },
                { text: "Русский", code: "ru" },
                { text: "Беларуская", code: "be" },
                { text: "English", code: "en" }
            ]
            Component.onCompleted: {
                var cur = Plasmoid.configuration.language || "auto";
                for (var i = 0; i < model.length; ++i) {
                    if (model[i].code === cur) {
                        currentIndex = i;
                        break;
                    }
                }
            }
            Layout.fillWidth: true
        }

        QQC2.ComboBox {
            id: intervalCombo
            Kirigami.FormData.label: i18n("Автообновление:")
            textRole: "text"
            model: [
                { text: i18n("Каждые 15 минут"), value: 15 },
                { text: i18n("Каждые 30 минут"), value: 30 },
                { text: i18n("Каждый 1 час"), value: 60 },
                { text: i18n("Каждые 2 часа"), value: 120 },
                { text: i18n("Только вручную"), value: 0 }
            ]
            Component.onCompleted: {
                for (var i = 0; i < model.length; ++i) {
                    if (model[i].value === Plasmoid.configuration.autoRefreshInterval) {
                        currentIndex = i;
                        break;
                    }
                }
            }
            Layout.fillWidth: true
        }

        QQC2.CheckBox {
            id: pastCheck
            Kirigami.FormData.label: i18n("История дня:")
            text: i18n("Показывать прошедшие пары за сегодня")
        }
    }
}
