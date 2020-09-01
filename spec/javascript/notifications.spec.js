import { shallowMount } from "@vue/test-utils";
import notifications from "../../app/javascript/parts/notifications";


describe('notifcations.vue', () => {

    describe('dropdown', () => {
        let wrapper

        beforeEach(()=>{
            wrapper = shallowMount(notifications)
        })

        it('initial state', ()=>{
            expect(wrapper.find('.toggle-button').exists()).toBeTruthy()
            expect(wrapper.find('.dropdown-content').exists()).toBeFalsy()
        })

        it('clicking toggle button show and hides content', async ()=>{
            await wrapper.find('.toggle-button').trigger('click')

            expect(wrapper.find('.dropdown-content').exists()).toBeTruthy()

            await wrapper.find('.toggle-button').trigger('click')

            expect(wrapper.find('.dropdown-content').exists()).toBeFalsy()
        })
    })

})