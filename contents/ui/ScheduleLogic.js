.pragma library

// ─── Translations & Localization ─────────────────────────────
var I18N = {
    ru: {
        code: "ru",
        name: "Русский",
        scheduleTitle: "Расписание БГУИР",
        weekLabel: "Неделя",
        noClasses: "Занятий нет",
        allDone: "Все занятия на сегодня завершены",
        subgroupShort: "п/г",
        subgroupFull: "подгруппа",
        now: "Сейчас",
        next: "Далее",
        today: "Сегодня",
        tomorrow: "Завтра",
        refresh: "Обновить расписание",
        loading: "Загрузка расписания...",
        retry: "Повторить",
        errorEmptyGroup: "Укажите номер группы в настройках",
        errorNotFound: "Группа %1 не найдена",
        errorServer: "Ошибка сервера БГУИР (код %1)",
        errorTimeout: "Таймаут подключения к серверу БГУИР",
        errorNetwork: "Не удалось подключиться к серверу БГУИР",
        typeLK: "Лекция",
        typeLR: "Лабораторная работа",
        typePZ: "Практическое занятие",
        typeExam: "Экзамен",
        typeConsultation: "Консультация",
        teacherLabel: "Преподаватель",
        auditoryLabel: "Аудитория",
        noteLabel: "Заметка",
        daysShort: ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"],
        daysFull: ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
        months: [
            "января", "февраля", "марта", "апреля", "мая", "июня",
            "июля", "августа", "сентября", "октября", "ноября", "декабря"
        ],
        holidays: {
            "1-1": "Новый год",
            "1-7": "Рождество (православное)",
            "3-8": "День женщин",
            "5-1": "Праздник труда",
            "5-9": "День Победы",
            "7-3": "День Независимости",
            "11-7": "День Октябрьской революции",
            "12-25": "Рождество (католическое)"
        }
    },
    be: {
        code: "be",
        name: "Беларуская",
        scheduleTitle: "Расклад БДУІР",
        weekLabel: "Тыдзень",
        noClasses: "Няма заняткаў",
        allDone: "На сёння заняткаў больш няма",
        subgroupShort: "п/г",
        subgroupFull: "падгрупа",
        now: "Зараз",
        next: "Далей",
        today: "Сёння",
        tomorrow: "Заўтра",
        refresh: "Абнавіць расклад",
        loading: "Загрузка раскладу...",
        retry: "Паўтарыць",
        errorEmptyGroup: "Пазначце нумар групы ў наладах",
        errorNotFound: "Група %1 не знойдзена",
        errorServer: "Памылка сервера БДУІР (код %1)",
        errorTimeout: "Таймаўт падключэння да сервера БДУІР",
        errorNetwork: "Не атрымалася падключыцца да сервера БДУІР",
        typeLK: "Лекцыя",
        typeLR: "Лабараторная работа",
        typePZ: "Практычны занятак",
        typeExam: "Экзамен",
        typeConsultation: "Кансультацыя",
        teacherLabel: "Выкладчык",
        auditoryLabel: "Аўдыторыя",
        noteLabel: "Нататка",
        daysShort: ["НД", "ПН", "АЎ", "СР", "ЧЦ", "ПТ", "СБ"],
        daysFull: ["Нядзеля", "Панядзелак", "Аўторак", "Серада", "Чацвер", "Пятніца", "Субота"],
        months: [
            "студзеня", "лютага", "сакавіка", "красавіка", "мая", "чэрвеня",
            "ліпеня", "жніўня", "верасня", "кастрычніка", "лістапада", "снежня"
        ],
        holidays: {
            "1-1": "Новы год",
            "1-7": "Раство Хрыстова (праваслаўнае)",
            "3-8": "Дзень жанчын",
            "5-1": "Свята працы",
            "5-9": "Дзень Перамогі",
            "7-3": "Дзень Незалежнасці",
            "11-7": "Дзень Кастрычніцкай рэвалюцыі",
            "12-25": "Раство Хрыстова (каталіцкае)"
        }
    },
    en: {
        code: "en",
        name: "English",
        scheduleTitle: "BSUIR Schedule",
        weekLabel: "Week",
        noClasses: "No classes",
        allDone: "No more classes for today",
        subgroupShort: "sub",
        subgroupFull: "subgroup",
        now: "Now",
        next: "Next",
        today: "Today",
        tomorrow: "Tomorrow",
        refresh: "Refresh schedule",
        loading: "Loading schedule...",
        retry: "Retry",
        errorEmptyGroup: "Specify group number in settings",
        errorNotFound: "Group %1 not found",
        errorServer: "BSUIR server error (code %1)",
        errorTimeout: "Connection timed out to BSUIR server",
        errorNetwork: "Failed to connect to BSUIR server",
        typeLK: "Lecture",
        typeLR: "Laboratory work",
        typePZ: "Practical class",
        typeExam: "Exam",
        typeConsultation: "Consultation",
        teacherLabel: "Instructor",
        auditoryLabel: "Room",
        noteLabel: "Note",
        daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
        daysFull: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        months: [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ],
        holidays: {
            "1-1": "New Year's Day",
            "1-7": "Orthodox Christmas",
            "3-8": "Women's Day",
            "5-1": "Labor Day",
            "5-9": "Victory Day",
            "7-3": "Independence Day",
            "11-7": "October Revolution Day",
            "12-25": "Catholic Christmas"
        }
    }
};

function getLanguage(langCode, systemLocale) {
    if (langCode === "ru" || langCode === "be" || langCode === "en") {
        return langCode;
    }
    var loc = (systemLocale || (typeof Qt !== "undefined" && Qt.locale ? Qt.locale().name : "ru")).toLowerCase();
    if (loc.indexOf("be") === 0) return "be";
    if (loc.indexOf("en") === 0) return "en";
    return "ru";
}

function tr(key, lang, param) {
    var l = lang || "ru";
    var dict = I18N[l] || I18N.ru;
    var str = dict[key] || I18N.ru[key] || key;
    if (param !== undefined) {
        str = str.replace("%1", param);
    }
    return str;
}

// ─── Default Colors ──────────────────────────────────────────
var DEFAULT_LESSON_COLORS = {
    "ЛК": "#3FB36F",          // Green
    "УЛк": "#3FB36F",
    "ЛР": "#F08A24",          // Orange
    "ПЗ": "#8E5CD9",          // Purple
    "УПз": "#8E5CD9",
    "Консультация": "#32ADE6",// Light Blue
    "Экзамен": "#FF3B30"      // Red
};

var FALLBACK_LESSON_COLOR = "#9A9A9E";

function getLessonAccentColor(type, overrides) {
    if (!type) return FALLBACK_LESSON_COLOR;
    if (overrides) {
        if ((type === "ЛК" || type === "УЛк") && overrides.colorLK) return overrides.colorLK;
        if (type === "ЛР" && overrides.colorLR) return overrides.colorLR;
        if ((type === "ПЗ" || type === "УПз") && overrides.colorPZ) return overrides.colorPZ;
        if (type === "Экзамен" && overrides.colorExam) return overrides.colorExam;
        if (type === "Консультация" && overrides.colorConsultation) return overrides.colorConsultation;
        if (overrides[type]) return overrides[type];
    }
    return DEFAULT_LESSON_COLORS[type] || FALLBACK_LESSON_COLOR;
}

var COLOR_BLUE = "#0A84FF";   // Today
var COLOR_RED = "#FF3B30";    // Tomorrow
var COLOR_ORANGE = "#FF9500"; // Future

// ─── Palettes ────────────────────────────────────────────────
var LIGHT_PALETTE = {
    bg: "#FFFFFF",
    cardBg: "#FFFFFF",
    textPrimary: "#000000",
    textSecondary: "#8E8E93",
    separator: "#E5E5EA",
    avatarBg: "#E5E5EA",
    border: "#E5E5EA"
};

var DARK_PALETTE = {
    bg: "#1C1C1E",
    cardBg: "#1C1C1E",
    textPrimary: "#FFFFFF",
    textSecondary: "#98989F",
    separator: "#38383A",
    avatarBg: "#3A3A3C",
    border: "#38383A"
};

function getPalette(themeMode, isSystemDark) {
    if (themeMode === 1) return DARK_PALETTE;
    if (themeMode === 2) return LIGHT_PALETTE;
    return isSystemDark ? DARK_PALETTE : LIGHT_PALETTE;
}

// ─── Date & Time Helpers ─────────────────────────────────────
var DAY_NAME_TO_DOW = {
    "Воскресенье": 0,
    "Понедельник": 1,
    "Вторник": 2,
    "Среда": 3,
    "Четверг": 4,
    "Пятница": 5,
    "Суббота": 6
};

var DOW_TO_DAY_NAME = [
    "Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"
];

function formatDayLabel(date, lang) {
    var l = lang || "ru";
    var dict = I18N[l] || I18N.ru;
    var dow = dict.daysShort[date.getDay()] || "";
    var m = dict.months[date.getMonth()] || "";
    return dow + ", " + date.getDate() + " " + m;
}

function getDayColor(targetDate, todayDate) {
    var d1 = new Date(targetDate.getFullYear(), targetDate.getMonth(), targetDate.getDate());
    var d0 = new Date(todayDate.getFullYear(), todayDate.getMonth(), todayDate.getDate());
    var diffDays = Math.round((d1.getTime() - d0.getTime()) / 86400000);
    if (diffDays === 0) return COLOR_BLUE;
    if (diffDays === 1) return COLOR_RED;
    return COLOR_ORANGE;
}

function minutesFromTime(timeStr) {
    if (!timeStr) return 0;
    var parts = timeStr.split(":");
    var h = parseInt(parts[0] || "0", 10);
    var m = parseInt(parts[1] || "0", 10);
    return h * 60 + m;
}

function nowMinutes() {
    var now = new Date();
    return now.getHours() * 60 + now.getMinutes();
}

function parseBsuirDate(str) {
    if (!str) return null;
    var parts = str.split(".");
    if (parts.length !== 3) return null;
    var day = parseInt(parts[0], 10);
    var month = parseInt(parts[1], 10) - 1;
    var year = parseInt(parts[2], 10);
    return new Date(year, month, day, 0, 0, 0, 0);
}

function toDateISO(date) {
    var y = date.getFullYear();
    var m = String(date.getMonth() + 1).padStart(2, '0');
    var d = String(date.getDate()).padStart(2, '0');
    return y + "-" + m + "-" + d;
}

function addDays(d, days) {
    var res = new Date(d.getTime());
    res.setDate(res.getDate() + days);
    return res;
}

function startOfLocalDay(d) {
    return new Date(d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0, 0);
}

function getStartOfMondayWeek(d) {
    var date = startOfLocalDay(d);
    var dow = date.getDay() || 7;
    date.setDate(date.getDate() - (dow - 1));
    return date;
}

function computeWeekForDate(date, today, currentWeek) {
    var todayMon = getStartOfMondayWeek(today);
    var dateMon = getStartOfMondayWeek(date);
    var daysDiff = Math.round((Date.UTC(dateMon.getFullYear(), dateMon.getMonth(), dateMon.getDate()) -
                              Date.UTC(todayMon.getFullYear(), todayMon.getMonth(), todayMon.getDate())) / 86400000);
    var weeksDiff = Math.floor(daysDiff / 7);
    var idx = (((currentWeek - 1 + weeksDiff) % 4) + 4) % 4;
    return idx + 1;
}

// ─── Teacher & Photo Helpers ─────────────────────────────────
function resolveTeacherPhoto(emp) {
    if (!emp) return null;
    var link = emp.photoLink;
    if (link && /^(https?:|file:|data:)/i.test(link)) return link;
    if (emp.id != null) return "https://iis.bsuir.by/api/v1/employees/photo/" + emp.id;
    return link || null;
}

function buildTeacherShort(emp) {
    if (!emp) return "";
    if (emp.fio) return emp.fio;
    var initials = "";
    if (emp.firstName && emp.firstName.length > 0) initials += emp.firstName[0] + ".";
    if (emp.middleName && emp.middleName.length > 0) initials += " " + emp.middleName[0] + ".";
    var last = emp.lastName || "";
    return (last + " " + initials).trim();
}

function getTeacherInitials(emp) {
    if (!emp) return "?";
    var f = emp.firstName ? emp.firstName[0] : "";
    var l = emp.lastName ? emp.lastName[0] : "";
    return (l + f) || "?";
}

function findHolidayName(date, lang) {
    var l = lang || "ru";
    var dict = I18N[l] || I18N.ru;
    var key = (date.getMonth() + 1) + "-" + date.getDate();
    return dict.holidays[key] || null;
}

// ─── Schedule Normalization ──────────────────────────────────
function lessonIsMine(numSubgroup, userSubgroup) {
    return userSubgroup === 0 || numSubgroup === 0 || numSubgroup === userSubgroup;
}

function normalizeLesson(lessonRaw, date, week, dayName, dayIndex, userSubgroup, colorOverrides, lang) {
    var numSubgroup = lessonRaw.numSubgroup || 0;
    var isMine = lessonIsMine(numSubgroup, userSubgroup);
    var typeAbbrev = lessonRaw.lessonTypeAbbrev || null;
    var accentColor = getLessonAccentColor(typeAbbrev, colorOverrides);
    var l = lang || "ru";

    var teachers = [];
    var teacherPhotos = [];
    var teacherNamesList = [];

    if (lessonRaw.employees && lessonRaw.employees.length > 0) {
        for (var i = 0; i < lessonRaw.employees.length; i++) {
            var emp = lessonRaw.employees[i];
            var photo = resolveTeacherPhoto(emp);
            var shortName = buildTeacherShort(emp);
            var initials = getTeacherInitials(emp);
            teachers.push({
                id: emp.id || 0,
                name: shortName,
                fullName: emp.fio || shortName,
                photoUrl: photo,
                initials: initials
            });
            if (photo) teacherPhotos.push(photo);
            teacherNamesList.push(shortName);
        }
    }

    var studentGroups = [];
    if (lessonRaw.studentGroups && lessonRaw.studentGroups.length > 0) {
        for (var g = 0; g < lessonRaw.studentGroups.length; g++) {
            studentGroups.push(lessonRaw.studentGroups[g].name);
        }
    }

    var auditories = lessonRaw.auditories || [];
    var auditoryText = auditories.length > 0 ? " · " + auditories.join(", ") : "";

    return {
        key: date.getTime() + "_" + dayIndex + "_" + lessonRaw.startLessonTime + "_" + numSubgroup + "_" + lessonRaw.subject,
        subject: lessonRaw.subject || "",
        subjectFullName: lessonRaw.subjectFullName || lessonRaw.subject || "",
        typeAbbrev: typeAbbrev,
        typeColorHex: accentColor,
        startTime: lessonRaw.startLessonTime || "",
        endTime: lessonRaw.endLessonTime || "",
        auditories: auditories,
        auditoryText: auditoryText,
        numSubgroup: numSubgroup,
        isMine: isMine,
        note: lessonRaw.note || null,
        teachers: teachers,
        teacherPhotos: teacherPhotos,
        teacherNames: teacherNamesList.join(", "),
        studentGroups: studentGroups,
        date: date,
        week: week,
        dayName: dayName
    };
}

function flattenSchedule(scheduleDto, currentWeek, today, userSubgroup, colorOverrides, lang) {
    if (!scheduleDto) return [];

    var effectiveSchedules = (scheduleDto.schedules && Object.keys(scheduleDto.schedules).length > 0)
        ? scheduleDto.schedules
        : scheduleDto.nextSchedules;

    if (!effectiveSchedules) return [];

    var startDate = parseBsuirDate(scheduleDto.startDate);
    var endDate = parseBsuirDate(scheduleDto.endDate);
    if (!startDate || !endDate) return [];

    var todayStart = startOfLocalDay(today);
    var out = [];

    // Periodic and announcement lessons
    var dayKeys = Object.keys(effectiveSchedules);
    for (var k = 0; k < dayKeys.length; k++) {
        var dayName = dayKeys[k];
        var dayLessons = effectiveSchedules[dayName];
        if (!dayLessons || dayLessons.length === 0) continue;

        var targetDow = DAY_NAME_TO_DOW[dayName];
        if (targetDow === undefined) continue;

        for (var dayIndex = 0; dayIndex < dayLessons.length; dayIndex++) {
            var lesson = dayLessons[dayIndex];
            if (!lesson) continue;

            if (lesson.dateLesson) {
                var singleDate = parseBsuirDate(lesson.dateLesson);
                if (!singleDate || singleDate < todayStart) continue;
                var singleWeek = computeWeekForDate(singleDate, todayStart, currentWeek);
                out.push(normalizeLesson(lesson, singleDate, singleWeek, dayName, dayIndex, userSubgroup, colorOverrides, lang));
                continue;
            }

            var lessonStart = parseBsuirDate(lesson.startLessonDate) || startDate;
            var lessonEnd = parseBsuirDate(lesson.endLessonDate) || endDate;
            var lessonWeeks = (lesson.weekNumber && lesson.weekNumber.length > 0) ? lesson.weekNumber : [1, 2, 3, 4];

            var cursor = startOfLocalDay(lessonStart);
            var cursorDow = cursor.getDay();
            var offset = (targetDow - cursorDow + 7) % 7;
            cursor = addDays(cursor, offset);

            while (cursor.getTime() <= lessonEnd.getTime()) {
                if (cursor.getTime() >= todayStart.getTime()) {
                    var week = computeWeekForDate(cursor, todayStart, currentWeek);
                    if (lessonWeeks.indexOf(week) !== -1) {
                        out.push(normalizeLesson(lesson, cursor, week, dayName, dayIndex, userSubgroup, colorOverrides, lang));
                    }
                }
                cursor = addDays(cursor, 7);
            }
        }
    }

    // Exam lessons
    if (scheduleDto.exams && scheduleDto.exams.length > 0) {
        for (var e = 0; e < scheduleDto.exams.length; e++) {
            var exam = scheduleDto.exams[e];
            if (!exam) continue;
            var examDate = parseBsuirDate(exam.dateLesson);
            if (!examDate || examDate < todayStart) continue;
            var examDayName = DOW_TO_DAY_NAME[examDate.getDay()] || "";
            var examWeek = computeWeekForDate(examDate, todayStart, currentWeek);
            out.push(normalizeLesson(exam, examDate, examWeek, examDayName, e, userSubgroup, colorOverrides, lang));
        }
    }

    out.sort(function(a, b) {
        var t = a.date.getTime() - b.date.getTime();
        if (t !== 0) return t;
        return a.startTime.localeCompare(b.startTime);
    });

    return out;
}

function groupLessonsByDay(lessons, lang) {
    var daysMap = {};
    var daysList = [];

    for (var i = 0; i < lessons.length; i++) {
        var lesson = lessons[i];
        var iso = toDateISO(lesson.date);
        if (!daysMap[iso]) {
            var dayObj = {
                date: lesson.date,
                dateISO: iso,
                dayOfWeek: lesson.date.getDay(),
                dayOfMonth: lesson.date.getDate(),
                month: lesson.date.getMonth(),
                dayLabel: formatDayLabel(lesson.date, lang),
                holidayName: findHolidayName(lesson.date, lang),
                lessons: []
            };
            daysMap[iso] = dayObj;
            daysList.push(dayObj);
        }
        daysMap[iso].lessons.push(lesson);
    }

    return daysList;
}

// ─── Display Resolution ──────────────────────────────────────
function resolveDisplay(scheduleDto, currentWeek, userSubgroup, showPastLessons, colorOverrides, lang) {
    var now = new Date();
    var todayStart = startOfLocalDay(now);
    var todayISO = toDateISO(now);
    var currentMins = nowMinutes();
    var l = lang || "ru";

    if (!scheduleDto) {
        return {
            hasData: false,
            lessons: [],
            displayDate: now,
            dateLabel: formatDayLabel(now, l),
            dateColor: COLOR_BLUE,
            groupName: "",
            currentWeek: currentWeek || 1,
            isNextDay: false,
            allDone: false,
            holidayName: findHolidayName(now, l)
        };
    }

    var groupName = (scheduleDto.studentGroupDto && scheduleDto.studentGroupDto.name) || "";
    var allLessons = flattenSchedule(scheduleDto, currentWeek, now, userSubgroup, colorOverrides, l);
    var days = groupLessonsByDay(allLessons, l);

    var todayDay = null;
    var nextDay = null;

    for (var i = 0; i < days.length; i++) {
        if (days[i].dateISO === todayISO) {
            todayDay = days[i];
        } else if (days[i].date.getTime() > todayStart.getTime()) {
            if (!nextDay) nextDay = days[i];
        }
    }

    // Check if today has lessons
    if (todayDay) {
        var remaining = [];
        for (var r = 0; r < todayDay.lessons.length; r++) {
            var item = todayDay.lessons[r];
            if (showPastLessons || minutesFromTime(item.endTime) > currentMins) {
                remaining.push(item);
            }
        }

        if (remaining.length > 0) {
            return {
                hasData: true,
                lessons: remaining,
                displayDate: todayDay.date,
                dateLabel: todayDay.dayLabel,
                dateColor: COLOR_BLUE,
                groupName: groupName,
                currentWeek: currentWeek,
                isNextDay: false,
                allDone: false,
                holidayName: todayDay.holidayName
            };
        }

        // All lessons today are finished -> show next day with lessons
        if (nextDay) {
            return {
                hasData: true,
                lessons: nextDay.lessons,
                displayDate: nextDay.date,
                dateLabel: nextDay.dayLabel,
                dateColor: getDayColor(nextDay.date, todayStart),
                groupName: groupName,
                currentWeek: currentWeek,
                isNextDay: true,
                allDone: true,
                holidayName: nextDay.holidayName
            };
        }

        // Today all finished, and no future days scheduled
        return {
            hasData: true,
            lessons: [],
            displayDate: todayDay.date,
            dateLabel: todayDay.dayLabel,
            dateColor: COLOR_BLUE,
            groupName: groupName,
            currentWeek: currentWeek,
            isNextDay: false,
            allDone: true,
            holidayName: todayDay.holidayName
        };
    }

    // No lessons today at all -> show next day
    if (nextDay) {
        return {
            hasData: true,
            lessons: nextDay.lessons,
            displayDate: nextDay.date,
            dateLabel: nextDay.dayLabel,
            dateColor: getDayColor(nextDay.date, todayStart),
            groupName: groupName,
            currentWeek: currentWeek,
            isNextDay: true,
            allDone: false,
            holidayName: nextDay.holidayName
        };
    }

    // No lessons today and no upcoming lessons
    return {
        hasData: true,
        lessons: [],
        displayDate: now,
        dateLabel: formatDayLabel(now, l),
        dateColor: COLOR_BLUE,
        groupName: groupName,
        currentWeek: currentWeek,
        isNextDay: false,
        allDone: false,
        holidayName: findHolidayName(now, l)
    };
}

// ─── Mock Data for Live Preview in Settings ───────────────────
function getMockLessons(colorOverrides, lang) {
    var l = lang || "ru";
    var isBe = l === "be";
    var isEn = l === "en";

    return [
        {
            key: "mock_1",
            subject: isEn ? "Computer Networks" : (isBe ? "Камп'ютарныя сеткі" : "Компьютерные сети"),
            subjectFullName: isEn ? "Computer Networks & Telecommunications" : (isBe ? "Камп'ютарныя сеткі і тэлекамунікацыі" : "Компьютерные сети и телекоммуникации"),
            typeAbbrev: "ЛК",
            typeColorHex: getLessonAccentColor("ЛК", colorOverrides),
            startTime: "09:00",
            endTime: "10:25",
            auditories: ["412-4 к."],
            auditoryText: " · 412-4 к.",
            numSubgroup: 0,
            isMine: true,
            note: isEn ? "Bring laboratory reports" : (isBe ? "Прынесці справаздачы" : "Принести отчёты по лабам"),
            teachers: [
                { id: 1, name: isEn ? "Ivanov I." : "Иванов И. И.", fullName: "Иванов Иван Иванович", photoUrl: "", initials: "ИИ" }
            ],
            teacherPhotos: [],
            teacherNames: isEn ? "Ivanov I. I." : "Иванов И. И.",
            studentGroups: []
        },
        {
            key: "mock_2",
            subject: isEn ? "Operating Systems" : (isBe ? "Аперацыйныя сістэмы" : "Операционные системы"),
            subjectFullName: isEn ? "Operating Systems & System Programming" : (isBe ? "Аперацыйныя сістэмы і сістэмнае праграмаванне" : "Операционные системы и системное программирование"),
            typeAbbrev: "ЛР",
            typeColorHex: getLessonAccentColor("ЛР", colorOverrides),
            startTime: "10:40",
            endTime: "12:05",
            auditories: ["208-4 к."],
            auditoryText: " · 208-4 к.",
            numSubgroup: 1,
            isMine: true,
            note: null,
            teachers: [],
            teacherPhotos: [],
            teacherNames: isEn ? "Petrov P. P." : "Петров П. П.",
            studentGroups: []
        },
        {
            key: "mock_3",
            subject: isEn ? "Mathematical Analysis" : (isBe ? "Матэматычны аналіз" : "Математический анализ"),
            subjectFullName: isEn ? "Higher Mathematics & Mathematical Analysis" : (isBe ? "Вышэйшая матэматыка" : "Высшая математика и математический анализ"),
            typeAbbrev: "ПЗ",
            typeColorHex: getLessonAccentColor("ПЗ", colorOverrides),
            startTime: "12:20",
            endTime: "13:45",
            auditories: ["301-1 к."],
            auditoryText: " · 301-1 к.",
            numSubgroup: 2,
            isMine: false,
            note: null,
            teachers: [],
            teacherPhotos: [],
            teacherNames: isEn ? "Sidorov S. S." : "Сидоров С. С.",
            studentGroups: []
        }
    ];
}
