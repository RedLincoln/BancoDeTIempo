import railsFlash from "../../app/javascript/railsFlash";

describe('Flash Message Dom manipulation', () => {

    describe('flash substitution without prior flash message', () => {

        beforeEach(()=>{
            document.body.innerHTML = `<div id="flash-messages" class="translate-animation"></div>`
        })

        it(':notice', ()=>{
            railsFlash.notice('Notice Message')

            const expected = document.querySelector('#flash-messages .notice')
            const expectedNoticeCount = document.getElementById('flash-messages')
                .getElementsByClassName('notice').length

            expect(expectedNoticeCount).toBe(1)
            expect(expected.outerHTML).toBe('<div class="flash-message notice">Notice message</div>')
        })
    })
})