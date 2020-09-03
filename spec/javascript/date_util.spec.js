import date_utils from "../../app/javascript/date_utils";

describe("date_utils", ()=>{

    describe("getNextMonthDate", ()=>{
        const RealDate = Date.now;

        afterEach(() => {
            global.Date.now = RealDate;
        });

        it("properly gets next month in same year", ()=>{
            global.Date.now = jest.fn(() => {
                return new Date("February 15, 1975 23:15:30").valueOf();
            });

            expect(date_utils.getNextMonthDate(new Date(Date.now())).valueOf())
                .toBe(new Date('March 1, 1975').valueOf())
        })

        it("properly gets next month after december of this year", ()=>{
            global.Date.now = jest.fn(() => {
                return new Date("December 15, 1975 23:15:30").valueOf();
            });

            expect(date_utils.getNextMonthDate(new Date(Date.now())).valueOf())
                .toBe(new Date('January 1, 1976').valueOf())
        })

    })

    describe("getPreviousMonthDate", ()=>{
        const RealDate = Date.now;

        afterEach(() => {
            global.Date.now = RealDate;
        });

        it("properly gets next month in same year", ()=>{
            global.Date.now = jest.fn(() => {
                return new Date("February 15, 1975 23:15:30").valueOf();
            });

            expect(date_utils.getPreviousMonthDate(new Date(Date.now())).valueOf())
                .toBe(new Date('January 1, 1975').valueOf())
        })

        it("properly gets next month after december of this year", ()=>{
            global.Date.now = jest.fn(() => {
                return new Date("January 15, 1975 23:15:30").valueOf();
            });

            expect(date_utils.getPreviousMonthDate(new Date(Date.now())).valueOf())
                .toBe(new Date('December 1, 1974').valueOf())
        })

    })

    describe("getOffsetWeekDayOfMonth", ()=>{

        it("give the right offset when the month start in the middle of the week", ()=>{
            const date = new Date("September 4, 2020") // first day is Tuesday (2)
            expect(date_utils.getOffsetWeekDayOfMonth(date)).toBe(1)
        })

        it("give the right offset when the month starts the sunday", ()=>{
            const date = new Date("November 4, 2020") // first day is Sunday (0)
            expect(date_utils.getOffsetWeekDayOfMonth(date)).toBe(6)
        })
    })
})