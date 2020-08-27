let arrayRegex = /(.+)\[(.+)\]/

export default {
    getPostParams: (elements) => {
        const result = {}
        for(let i = 0; i < elements.length; i++){
            const element =  elements.item(i)
            if (arrayRegex.test(element.name)){
                const [empty, key, value] = element.name.match(arrayRegex)
                if (!result.hasOwnProperty(key)){
                    result[key] = {}
                }
                result[key][value] = element.value
            }else{
                result[element.name] = element.value
            }
        }
        return result
    }
}
