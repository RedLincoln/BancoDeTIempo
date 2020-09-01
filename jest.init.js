import { config } from "@vue/test-utils";

config.mocks['$cable'] = {
    subscriptions: {
        remove: (options)=> {},
        create: (options)=> {}
    }
}

config.mocks['$userNotificationsPath'] = '/user/notifications'