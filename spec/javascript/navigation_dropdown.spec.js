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

    it('should render dropdown_content', () =>  {
        const props = {
            links: [{href: 'link1', text: 'text1'}, {href: 'link2', text: 'text2'}]
        }
        const wrapper = shallowMount(navigation_dropdown, {
            propsData: props,
            data() {
                return {
                    show: true
                }
            }
        })

        const content = wrapper.find('.dropdown_content').findAll('a')
        expect(content.wrappers.map((el) => el.text())).toEqual(props.links.map((l) => l.text))
        expect(content.wrappers.map((el) => el.attributes('href'))).toEqual(props.links.map((l) => l.href))
    })

    it('clicking on toggle button show the content', async () => {
        const wrapper = shallowMount(navigation_dropdown)

        await wrapper.find('.toggle_button').trigger('click')

        expect(wrapper.find('.dropdown_content').exists()).toBeTruthy()
    })

    it('clicking on toggle button hide the content', async () => {
        const wrapper = shallowMount(navigation_dropdown, {
            data() {
                return {
                    show: true
                }
            }
        })

        await wrapper.find('.toggle_button').trigger('click')

        expect(wrapper.find('.dropdown_content').exists()).toBeFalsy()
    })
})