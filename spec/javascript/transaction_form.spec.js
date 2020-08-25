import { shallowMount} from "@vue/test-utils";
import transaction_form from "../../app/javascript/parts/transaction_form";

describe ('transaction_form.vue',  ()=>{

    it ('initially hide content', ()=>{
        const wrapper = shallowMount(transaction_form)

        expect(wrapper.find('.form').exists()).toBeFalsy()
    })

    describe('', () => {
        let wrapper

        beforeEach(()=> {
            wrapper = shallowMount(transaction_form, {
                data(){
                    return {
                        show: true
                    }
                }

            })
        })

        it ('show content', ()=>{
            expect(wrapper.find('.form').exists()).toBeTruthy()
        })
    })
})