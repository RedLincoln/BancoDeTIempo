import { shallowMount} from "@vue/test-utils";
import MockAdapter from "axios-mock-adapter";
import axios from 'axios'
import transaction_form from "../../app/javascript/parts/transaction_form";

jest.mock('../../app/javascript/setupAxios')

describe ('transaction_form.vue',  ()=>{

    describe('', ()=>{
        let wrapper

        beforeEach(()=>{
            wrapper = shallowMount(transaction_form, {
                mocks: {
                    $getCSRFToken: () => ''
                }
            })
        })

        it ('initially hide content', ()=>{
            expect(wrapper.find('.form').exists()).toBeFalsy()
        })

        it ('show content when click on button', async() => {
            await wrapper.find('.open_petition').trigger('click')

            expect(wrapper.find('.form').exists()).toBeTruthy()
        })

    })

    describe('', () => {
        let wrapper
        let axiosMock
        const $createTransactionPath =  '/transactions.js'

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
                    $createTransactionPath: $createTransactionPath,
                    $getCSRFToken: () => ''
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
            axiosMock.onPost($createTransactionPath).reply(200, { message: 'err'})

            wrapper.find('.form').trigger('submit')

            expect(spy).toBeCalledTimes(1)
        })
    })
})