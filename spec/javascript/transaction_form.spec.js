import { shallowMount} from "@vue/test-utils";
import MockAdapter from "axios-mock-adapter";
import axios from 'axios'
import transaction_form from "../../app/javascript/parts/transaction_form";

describe ('transaction_form.vue',  ()=>{

    it ('initially hide content', ()=>{
        const wrapper = shallowMount(transaction_form)
        expect(wrapper.find('.form').exists()).toBeFalsy()
    })

    it ('show content when click on button', async() => {
        const wrapper = shallowMount(transaction_form)

        await wrapper.find('.open_petition').trigger('click')

        expect(wrapper.find('.form').exists()).toBeTruthy()
    })

    describe('', () => {
        let wrapper
        let axiosMock
        const $createTransactionPath =  '/transactions'

        beforeEach(()=> {
            jest.clearAllMocks()
            axiosMock  = new MockAdapter(axios)

            wrapper = shallowMount(transaction_form, {
                data(){
                    return {
                        show: true
                    }
                },
                mocks: {
                    $createTransactionPath: $createTransactionPath
                }
            })
        })

        it ('show content', ()=>{
            expect(wrapper.find('.form').exists()).toBeTruthy()
        })

        it ('hides content when click on button', async() => {
            await wrapper.find('.open_petition').trigger('click')
            expect(wrapper.find('.form').exists()).toBeFalsy()
        })

        it ('sends petition once clicked in send petition', () => {
            const spy = jest.spyOn(axios, 'post')
            axiosMock.onPost($createTransactionPath, {
                transaction: {
                    datetime: wrapper.find('.time_petition'),
                    additional_information: wrapper.find('.additional_information')
                }
            }).reply(200)

            wrapper.find('.send_petition').trigger('click')

            expect(spy).toBeCalledTimes(1)
        })
    })
})