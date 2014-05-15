-module (lwes_app).

-behaviour (application).

%% API
-export([start/0]).

%% application callbacks
-export ([start/2, stop/1]).

%-=====================================================================-
%-                                  API                                -
%-=====================================================================-
start () ->
  [ensure_started (App) || App <- [sasl, lwes]].

%-=====================================================================-
%-                        application callbacks                        -
%-=====================================================================-
start (_Type, _Args) ->
  lwes_sup:start_link().

stop (_State) ->
  ok.

%-=====================================================================-
%-                               Private                               -
%-=====================================================================-
ensure_started(App) ->
  case application:start(App) of
    ok ->
      ok;
    {error, {already_started, App}} ->
      ok
  end.

%-=====================================================================-
%-                            Test Functions                           -
%-=====================================================================-
-ifdef (TEST).
-include_lib ("eunit/include/eunit.hrl").

lwes_app_test_ () ->
  [
    ?_assertEqual ([ok, ok],lwes_app:start()),
    ?_assertEqual ([ok, ok],lwes_app:start()),
    ?_assertEqual (ok, application:stop (lwes))
  ].

-endif.
