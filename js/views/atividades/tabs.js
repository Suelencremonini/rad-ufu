define([

    "util/evAggregator",
    "../../../components/require/text!templates/atividades/tabs.html",
    "collections/categoria"

    ], function(evAggregator, tabsCategoriaTpl, CategoriaCollection) {

        var CategoriaTabsView = Backbone.View.extend({

            el : "#categorias",

            collection : CategoriaCollection,

            initialize : function() {
                this.listenTo(evAggregator, "view:atividades:categorias", this.render);
            },

            render : function(categoria) {

                // esta view depende de 'views/atividades/frame' que cria
                // o elemento '#categorias', por isso temos que pegar do DOM
                // embora o Backbone tente fazer isso na hora da instanciação

                this.$el = $("#categorias");

                this.collection.fetch();

                this.$el.html(_.template(tabsCategoriaTpl, {
                    categorias  : this.collection,
                    selecionada : decodeURIComponent(categoria)
                }));

                return this;

            }
        });

        return CategoriaTabsView;

});