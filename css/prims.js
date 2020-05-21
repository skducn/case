
            
            var currentRoute = false;


            function enterTransition(name, callback) {

                var element = $('#'+name);

                element.removeClass('hide');

                setTimeout(function() {
                    element.addClass('show')
                        .addClass('appear');

                    setTimeout(function() {
                        element.addClass('flow');
                        return callback();
                    }, 1000);
                }, 100);

            }

            function leaveTransition(name, callback) {

                var element = $('#'+name);

                element.removeClass('flow')
                    .removeClass('show');

                setTimeout(function() {
                    element.removeClass('appear');

                    setTimeout(function() {
                        element.addClass('hide');
                        return callback();
                    }, 500);
                }, 300);
            }

            var routes = {

                // Landing Page Animation
                index: {
                    enter: function(callback) {

                        $('#landing').removeClass('hide');

                        setTimeout(function() {
                            $('#landing').addClass('show');
                            return callback();
                        }, 100);

                    },
                    leave: function(callback) {

                        $('#landing').removeClass('show');

                        setTimeout(function() {
                            $('#landing').addClass('hide');
                            return callback();
                        }, 500);

                    }
                },

                // Example Page Animation
                examples: {
                    enter: function(callback) {
                        enterTransition('example', callback);
                    },
                    leave: function(callback) {
                        leaveTransition('example', callback);
                    }
                },

           

            }

            function routing() {

                var hash = window.location.hash.replace('#', '');

                if (!hash.length) {
                    hash = 'index';
                }

                if (['index', 'examples', 'start', 'api', 'faq'].indexOf(hash) === -1) {
                    return false;
                }

                if (currentRoute === false) {
                    return routes[hash].enter(function() {
                        currentRoute = hash;
                    });
                }

                return routes[currentRoute].leave(function() {
                    routes[hash].enter(function() {
                        currentRoute = hash;
                    });
                });

            }

            function init() {
                setTimeout(function() {
                    $('#navigation').addClass('show');
                    routing();
                }, 500);
            }

            $(document).on('ready', function() {

                // Init Waves
                Waves.init();
                Waves.attach('.drag-ripple', 'waves-block', true);
                Waves.attach('#bg-pattern', null, true);
                

                init();

                $(window).on('hashchange', routing);


                /**
                 * Example source code click
                 */
                $('#example .top-button').on('click', function() {

                    var type = $(this).data('code');

                    $('#source-code .box .code').addClass('hide');
                    $('#source-code .box #code-'+type).removeClass('hide');
                    $('#source-code').removeClass('hide');

                    setTimeout(function() {
                        $('#source-code').addClass('show');
                    }, 50);

                });

                $('#source-code .top-button').on('click', function() {

                    $('#source-code').removeClass('show');

                    setTimeout(function() {
                        $('#source-code .box .code').addClass('hide');
                        $('#source-code').addClass('hide');
                    }, 500);
                });
            });

