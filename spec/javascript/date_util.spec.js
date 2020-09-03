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

            expect(date_utils.getNextMonthDate(new Date(Date.now())).getMilliseconds())
                .toBe(new Date('March 1, 1975').getMilliseconds())
        })


    })
})