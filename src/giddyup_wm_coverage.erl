%% @doc After coverage report generated, this resource shoves it out.
-module(giddyup_wm_coverage).

-record(context, {file, test_result}).

-export([
    init/1,
    routes/0,
    resource_exists/2,
    to_html/2
]).

-include("giddyup_wm_auth.hrl").

routes() ->
    [{["test_results", id, "coverage", '*'], ?MODULE, []}].

init(_) ->
    {ok, #context{}}.

resource_exists(RD, Context) ->
    TestResId = wrq:path_info(id, RD),
    TailPath = wrq:disp_path(RD),
    LocalPath = filename:join(["tmp", "coverage", TestResId, TailPath]),
    lager:debug("coverage resource - TestResId: ~s, TailPath: ~p; LocalPath: ~p", [TestResId, TailPath, LocalPath]),
    {Boolean, File} = case filelib:is_dir(LocalPath) of
        true ->
            {true, filename:join(LocalPath, "index.html")};
        false ->
            case filelib:is_file(LocalPath) of
                false ->
                    {false, undefined};
                true ->
                    {true, LocalPath}
            end
    end,
    {Boolean, RD, Context#context{file = File}}.

to_html(RD, Context) ->
    File = Context#context.file,
    lager:debug("Spitting out contents of ~s", [File]),
    {ok, Binary} = file:read_file(File),
    {Binary, RD, Context}.

