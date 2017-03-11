/**
 * Created by Asus on 11.03.2017.
 */
Vue.use(VueRouter);

var Home = Vue.extend({
    template:'#calculatorTemplate'
});

var NewOperation = Vue.extend({
    template:'#newTemplate',
    data:function(){
        return {
            operation:{}
        };
    },
    methods:{
        save:function(){
            this.$http.post("/operation/new",this.operation).then(function(response){
                if(response.data) {
                    router.replace({name:'movieView',params:{movieId:response.data.id}});
                }
            }).catch(function(ex){
                alert("Error" + ex);
            });
        }
    }
});

var App = Vue.extend({});
var router = new VueRouter();
router.map({
    '/':{
        component:Home
    },
    '/new':{
        name:'operation',
        component:NewOperation
    }
});
router.start(App, '#app')