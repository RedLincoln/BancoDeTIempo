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

            expect(expect).toEqual({ name: 'the_value' })
        })
    })
})