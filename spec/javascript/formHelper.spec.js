import formHelper from "../../app/javascript/formHelper";

describe('form helper', ()=>{

    describe('normal parameters', () => {
        let params

        beforeEach(() => {
            let form = document.createElement('form')
            form.innerHTML = '<input name="name" value="the_value">'
            params = form.elements
        })

        it('are converted properly', ()=>{
            const expected = formHelper.getPostParams(params)

            expect(expected).toEqual({ name: 'the_value' })
        })
    })

    describe('array parameters', () => {
        let params

        beforeEach(() => {
            let form = document.createElement('form')
            form.innerHTML = `<input name="name[1]" value="the_value1">
                              <input name="name[2]" value="the_value2">`
            params = form.elements
        })

        it('are converted properly', () => {
            const expected = formHelper.getPostParams(params)

            expect(expected).toEqual({
                name: {
                    1: 'the_value1',
                    2: 'the_value2'
                }})
        })
    })

    describe('datetime parameters', () => {
        let params

        beforeEach(() => {
            let form = document.createElement('form')
            form.innerHTML = `<input name="name[1]" value="the_value1">
                              <input data-type="datetime" name="name[2]" value="2020/0/2 12:00">`
            params = form.elements
        })

        it('are converted properly', () => {
            const expected = formHelper.getPostParams(params)

            expect(expected).toEqual({
                name: {
                    1: 'the_value1',
                    2: new Date(2020, 0, 2, 12, 0, 0).getTime()
                }})
        })

        it("empty string is converted to empty string", ()=>{
            params.item(1).value =""
            const expected = formHelper.getPostParams(params)

            expect(expected).toEqual({
                name: {
                    1: 'the_value1',
                    2: ""
                }})
        })
    })
})