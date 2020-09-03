const month = {
    0: 'Enero',
    1: 'Febrero',
    2: 'Marzo',
    3: 'Abril',
    4: 'Mayo',
    5: 'Junio',
    6: 'Julio',
    7: 'Agosto',
    8: 'Septiembre',
    9: 'Octubre',
    10: 'Noviembre',
    11: 'Diciembre'
}

export default {
    getMonth(index) {
        return month[index]
    },

    getDaysInMonth(year, month){
        return new Date(
            year,
            month,
            0
        ).getDate();
    },

    getNextMonthDate(date) {
        return new Date(date.getFullYear(), date.getMonth() + 1, 1)
    },

    getPreviousMonthDate(date) {
        return new Date(date.getFullYear(), date.getMonth() - 1, 1)
    }
}