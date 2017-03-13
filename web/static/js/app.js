/**
 * Created by Asus on 11.03.2017.
 */
Vue.use(VueRouter);
Vue.use(VueResource);

var Operation = Vue.extend({
    template:'#operationsTemplate',
    data:function() {
        alert('OPERATIONS COMPONENT');
        this.$http.get("/operation").then(function(response){
            this.$set('operations', response.data);
            alert('OPERATIONS');
        })
    }
});

var Calculator = Vue.extend({
    template:'#calculatorTemplate',
    data:function(){
        return {
            operation:{
                period:3,
                amount_receipts:0,
                amount_income:0,
                job_availability:0,
                benefits_availability:1,
                lonely: 0,
                number_child: 0,
                number_child_invalid: 0,
                dependent: 0,
                amount_contribution: 0,
                amount_education:0,
                amount_building:0,
                amount_entrepreneurial_activity: 0
            },
            show: true,
            show_result: false
        };
    },
    methods: {
        calculate: function () {
            this.$http.post("/operation/new",this.operation).then(function(response) {
                this.operation = response.data;
                this.show_result = true;
            }, function(error){
                alert('error ');
            });
        },
        check_child: function () {
            var number_child = document.getElementById("number_child").value;
            var number_child_invalid = document.getElementById("number_child_invalid").value;
            if (number_child_invalid > number_child) {
                var n = parseInt(number_child_invalid.charAt(number_child_invalid.length - 1));
                this.operation.number_child_invalid = (number_child_invalid - n) / 10;
            }
        }

    }
});

var router = new VueRouter({
    routes:[
        { path: '/', component: Calculator },
        { path: '/operation', component: Operation }
    ]
});

var app = new Vue({
    router: router
}).$mount('#app');
