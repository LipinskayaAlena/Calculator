/**
 * Created by Asus on 11.03.2017.
 */
Vue.use(VueRouter);

var Home = Vue.extend({
    template:'tableCalculator'
});

var App = Vue.extend({});
var router = new VueRouter();
router.map({
    '/':{
        component:Home
    },
    '/calculate':{
        name:'operation',
        component:Operation
    }
});
router.start(App, '#app')