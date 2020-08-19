import { shallowMount } from "@vue/test-utils";
import navigation_dropdown from "../../app/javascript/parts/navigation_dropdown";

describe('navigation_dropdown.vue', ()=>{

    it('initial state is no show', () =>  {
        const props = {
            title: 'title'
        }
        const wrapper = shallowMount(navigation_dropdown, {
            propsData: props
        })

        expect(wrapper.find('.dropdown_title').text()).toBe(props.title)
        expect(wrapper.find('.dropdown_content').exists()).toBeFalsy()
    })
})