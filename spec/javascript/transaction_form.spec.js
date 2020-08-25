import { shallowMount} from "@vue/test-utils";
import transaction_form from "../../app/javascript/parts/transaction_form";

describe ('transaction_form.vue',  ()=>{

    it ('show content', ()=>{
        const wrapper = shallowMount(transaction_form, {
            data(){
                return {
                    show: true
                }
            }

        })

        expect(wrapper.find('.form').exists()).toBeTruthy()
    })

    it ('initially hide content', ()=>{
        const wrapper = shallowMount(transaction_form)

        expect(wrapper.find('.form').exists()).toBeFalsy()
    })
})