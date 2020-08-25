import railsFlash from "../../app/javascript/railsFlash";

describe('Flash Message Dom manipulation', () => {

    describe('flash substitution without prior flash message', () => {

        beforeEach(()=>{
            document.body.innerHTML = `<div id="flash-messages" class="translate-animation"></div>`
        })

        it(':notice', ()=>{
            const message = 'Notice Message'
            railsFlash.notice(message)

            const expected = document.getElementById('flash-messages').innerHTML

            expect(expected).toBe(`<div class="flash-message notice">${message}</div>`)
        })

        it(':alert', ()=>{
            const message = 'Alert Message'
            railsFlash.alert(message)

            const expected = document.getElementById('flash-messages')

            expect(expected.innerHTML).toBe(`<div class="flash-message alert">${message}</div>`)
        })
    })

    describe('flash substitution with prior message', () => {

        beforeEach(()=>{
            document.body.innerHTML = `<div id="flash-messages" class="translate-animation">
                                           <div class="flash-message notice">Notice Message</div>
                                           <div class="flash-message alert">Alert Message</div>
                                       </div>`
        })

        it(':notice', ()=>{
            const message = 'Notice Message'
            railsFlash.notice(message)

            const expected =  document.getElementById('flash-messages').innerHTML

            expect(expected).toBe(`<div class="flash-message notice">${message}</div>`)
        })

    })
})