export default {
    getPostParams: (elements) => {
        const result = {}
        for(let i = 0; i < elements.length; i++){
            const element =  elements.item(i)
            result[element.name] = element.value
        }
        return result
    }
}