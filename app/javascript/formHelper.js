let arrayRegex = /(.+)\[(.+)\]/

const convertDatetime = (stringDatetime) => {
    stringDatetime = stringDatetime.trim()
    const [date, time] = stringDatetime.split(' ')
    const [ year, month, day] = date.split('/')
    const [ hour, minutes ] = time.split(':')
    return new Date(year, month , day, hour, minutes).getTime()
}

export default {
    getPostParams: (elements) => {
        const result = {}
        for(let i = 0; i < elements.length; i++){
            const element =  elements.item(i)
            let fieldValue = element.value
            if (element.dataset.type === "datetime"){
                fieldValue = convertDatetime(element.value)
            }
            if (arrayRegex.test(element.name)){
                const [empty, key, value] = element.name.match(arrayRegex)
                if (!result.hasOwnProperty(key)){
                    result[key] = {}
                }
                result[key][value] = fieldValue
            }else{
                result[element.name] = fieldValue
            }
        }
        return result
    }
}
