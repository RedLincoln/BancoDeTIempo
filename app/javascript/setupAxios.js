export default {
    getDefaultHeader: () => {
        const token = document.querySelector("meta[name=csrf-token]")
        return {
            common: {
                'X-CSRF-Token': token.content
            }
        }
    }
}
