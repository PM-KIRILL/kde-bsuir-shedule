.pragma library

// ─── Colors ──────────────────────────────────────────────────
var LESSON_TYPE_COLORS = {
    "ПЗ": "#8E5CD9",          // Purple
    "ЛР": "#F08A24",          // Orange
    "ЛК": "#3FB36F",          // Green
    "Консультация": "#32ADE6",// Light Blue
    "Экзамен": "#FF3B30",     // Red
    "УПз": "#8E5CD9",         // Supervised practical
    "УЛк": "#3FB36F"          // Supervised lecture
};

var FALLBACK_LESSON_COLOR = "#9A9A9E";

function getLessonAccentColor(type) {
    if (!type) return FALLBACK_LESSON_COLOR;
    return LESSON_TYPE_COLORS[type] || FALLBACK_LESSON_COLOR;
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
var DAY_NAMES_SHORT = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"];
var MONTH_NAMES = [
    "января", "февраля", "марта", "апреля", "мая", "июня",
    "июля", "августа", "сентября", "октября", "ноября", "декабря"
];

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

function formatDayLabel(date) {
    var dow = DAY_NAMES_SHORT[date.getDay()] || "";
    var m = MONTH_NAMES[date.getMonth()] || "";
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

// ─── Holidays ────────────────────────────────────────────────
var FIXED_HOLIDAYS = [
    { month: 1, day: 1, name: "Новый год" },
    { month: 1, day: 7, name: "Рождество (православное)" },
    { month: 3, day: 8, name: "День женщин" },
    { month: 5, day: 1, name: "День труда" },
    { month: 5, day: 9, name: "День Победы" },
    { month: 7, day: 3, name: "День Независимости" },
    { month: 11, day: 7, name: "День Октябрьской революции" },
    { month: 12, day: 25, name: "Рождество (католическое)" }
];

function findHolidayName(date) {
    var m = date.getMonth() + 1;
    var d = date.getDate();
    for (var i = 0; i < FIXED_HOLIDAYS.length; i++) {
        if (FIXED_HOLIDAYS[i].month === m && FIXED_HOLIDAYS[i].day === d) {
            return FIXED_HOLIDAYS[i].name;
        }
    }
    return null;
}

// ─── Schedule Normalization ──────────────────────────────────
function lessonIsMine(numSubgroup, userSubgroup) {
    return userSubgroup === 0 || numSubgroup === 0 || numSubgroup === userSubgroup;
}

function normalizeLesson(lessonRaw, date, week, dayName, dayIndex, userSubgroup) {
    var numSubgroup = lessonRaw.numSubgroup || 0;
    var isMine = lessonIsMine(numSubgroup, userSubgroup);
    var typeAbbrev = lessonRaw.lessonTypeAbbrev || null;
    var accentColor = getLessonAccentColor(typeAbbrev);

    var teachers = [];
    var teacherPhotos = [];
    var teacherInitialsList = [];
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
            teacherInitialsList.push(initials);
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

function flattenSchedule(scheduleDto, currentWeek, today, userSubgroup) {
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
                out.push(normalizeLesson(lesson, singleDate, singleWeek, dayName, dayIndex, userSubgroup));
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
                        out.push(normalizeLesson(lesson, cursor, week, dayName, dayIndex, userSubgroup));
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
            out.push(normalizeLesson(exam, examDate, examWeek, examDayName, e, userSubgroup));
        }
    }

    out.sort(function(a, b) {
        var t = a.date.getTime() - b.date.getTime();
        if (t !== 0) return t;
        return a.startTime.localeCompare(b.startTime);
    });

    return out;
}

function groupLessonsByDay(lessons) {
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
                dayLabel: formatDayLabel(lesson.date),
                holidayName: findHolidayName(lesson.date),
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
function resolveDisplay(scheduleDto, currentWeek, userSubgroup, showPastLessons) {
    var now = new Date();
    var todayStart = startOfLocalDay(now);
    var todayISO = toDateISO(now);
    var currentMins = nowMinutes();

    if (!scheduleDto) {
        return {
            hasData: false,
            lessons: [],
            displayDate: now,
            dateLabel: formatDayLabel(now),
            dateColor: COLOR_BLUE,
            groupName: "",
            currentWeek: currentWeek || 1,
            isNextDay: false,
            allDone: false,
            holidayName: findHolidayName(now)
        };
    }

    var groupName = (scheduleDto.studentGroupDto && scheduleDto.studentGroupDto.name) || "";
    var allLessons = flattenSchedule(scheduleDto, currentWeek, now, userSubgroup);
    var days = groupLessonsByDay(allLessons);

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
            var l = todayDay.lessons[r];
            if (showPastLessons || minutesFromTime(l.endTime) > currentMins) {
                remaining.push(l);
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
        dateLabel: formatDayLabel(now),
        dateColor: COLOR_BLUE,
        groupName: groupName,
        currentWeek: currentWeek,
        isNextDay: false,
        allDone: false,
        holidayName: findHolidayName(now)
    };
}
