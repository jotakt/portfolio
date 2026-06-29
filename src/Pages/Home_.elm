module Pages.Home_ exposing (Model, Msg, page)

import Browser.Dom as Dom
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, preventDefaultOn)
import Json.Decode as Decode
import Page exposing (Page)
import Task
import View exposing (View)


page : Page Model Msg
page =
    Page.element
        { init = ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { menuOpen : Bool
    }


init : Model
init =
    { menuOpen = False
    }



-- UPDATE


type Msg
    = ToggleMenu
    | CloseMenu
    | ScrollTo String
    | ScrollToTop
    | Scrolled (Result Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            ( { model | menuOpen = not model.menuOpen }, Cmd.none )

        CloseMenu ->
            ( { model | menuOpen = False }, Cmd.none )

        ScrollTo id ->
            ( { model | menuOpen = False }
            , Dom.getElement id
                |> Task.andThen (\info -> Dom.setViewport 0 info.element.y)
                |> Task.attempt Scrolled
            )

        ScrollToTop ->
            ( { model | menuOpen = False }
            , Dom.setViewport 0 0
                |> Task.attempt Scrolled
            )

        Scrolled _ ->
            ( model, Cmd.none )


onClickPreventDefault : msg -> Attribute msg
onClickPreventDefault msg =
    preventDefaultOn "click" (Decode.succeed ( msg, True ))



-- VIEW


view : Model -> View Msg
view model =
    { title = "João Costa | Desenvolvedor Fullstack"
    , body =
        [ viewNav model
        , viewMobileMenu model
        , main_ []
            [ viewHero
            , viewAbout
            , viewStack
            , viewProjects
            , viewContact
            ]
        , viewFooter
        ]
    }



-- NAV


viewNav : Model -> Html Msg
viewNav model =
    header [ class "nav" ]
        [ nav [ class "nav__inner" ]
            [ a [ href "/", class "nav__logo", onClickPreventDefault ScrollToTop ]
                [ text "JM"
                ]
            , div [ class "nav__links" ]
                [ a [ href "#about", onClickPreventDefault (ScrollTo "about") ] [ text "About" ]
                , a [ href "#stack", onClickPreventDefault (ScrollTo "stack") ] [ text "Stack" ]
                , a [ href "#work", onClickPreventDefault (ScrollTo "work") ] [ text "Work" ]
                , a [ href "#contact", class "nav__cta", onClickPreventDefault (ScrollTo "contact") ] [ text "Hire Me" ]
                ]
            , button
                [ class
                    (if model.menuOpen then
                        "nav__hamburger nav--open"

                     else
                        "nav__hamburger"
                    )
                , onClick ToggleMenu
                , attribute "aria-label" "Abrir menu"
                ]
                [ span [] []
                , span [] []
                , span [] []
                ]
            ]
        ]


viewMobileMenu : Model -> Html Msg
viewMobileMenu model =
    div
        [ class
            (if model.menuOpen then
                "nav-mobile nav-mobile--open"

             else
                "nav-mobile"
            )
        ]
        [ a [ href "#about", onClickPreventDefault (ScrollTo "about") ] [ text "About" ]
        , a [ href "#stack", onClickPreventDefault (ScrollTo "stack") ] [ text "Stack" ]
        , a [ href "#work", onClickPreventDefault (ScrollTo "work") ] [ text "Work" ]
        , a [ href "#contact", onClickPreventDefault (ScrollTo "contact") ] [ text "Hire Me →" ]
        ]



-- HERO


viewHero : Html Msg
viewHero =
    section [ class "hero" ]
        [ span [ class "hero__badge" ] [ text "Disponível para Projetos" ]
        , h1 [ class "hero__name" ]
            [ text "JOÃO"
            , br [] []
            , em [] [ text "COSTA" ]
            ]
        , div [ class "hero__bottom" ]
            [ h2 [ class "hero__title" ]
                [ text "DESENVOLVEDOR"
                , br [] []
                , text "FULLSTACK"
                ]
            , div [ class "hero__side" ]
                [ p [] [ text "Entusiasta por tecnologia." ]
                , a
                    [ href "/curriculo.pdf"
                    , download "curriculo.pdf"
                    , target "_blank"
                    , class "btn btn--primary"
                    ]
                    [ text "Baixar Currículo"
                    ]
                ]
            , p [ class "hero__scroll-hint" ] [ text "Rolar para ver projetos" ]
            ]
        ]



-- ABOUT


viewAbout : Html Msg
viewAbout =
    section [ class "section", id "about" ]
        [ p [ class "section__label" ] [ text "Sobre mim" ]
        , div [ class "about__grid" ]
            [ div [ class "about__card" ]
                [ h3 [] [ text "// BIO" ]
                , p []
                    [ text "Estudante de Ciência da Computação com foco em Backend. Especialista em Python e linguagens funcionais." ]
                ]
            , div [ class "about__text" ]
                [ p []
                    [ text "Minha abordagem é pragmática: código limpo, sistemas distribuídos e alta escalabilidade. Busco resolver problemas complexos com soluções simples em Python/TS e Elm." ]
                , p []
                    [ text "Acredito que a escolha correta de abstrações e ferramentas é o que diferencia um sistema bom de um sistema excelente. Cada decisão técnica importa." ]
                , dl [ class "about__stats" ]
                    [ div [ class "about__stat-item" ]
                        [ dt [] [ text "2+" ]
                        , dd [] [ text "Anos de experiência" ]
                        ]
                    , div [ class "about__stat-item" ]
                        [ dt [] [ text "10+" ]
                        , dd [] [ text "Projetos entregues" ]
                        ]
                    , div [ class "about__stat-item" ]
                        [ dt [] [ text "∞" ]
                        , dd [] [ text "Café consumido" ]
                        ]
                    ]
                ]
            ]
        ]



-- STACK


type alias TechItem =
    { name : String
    , desc : String
    , featured : Bool
    }


techStack : List TechItem
techStack =
    [ { name = "PYTHON", desc = "FastAPI / Django", featured = True }
    , { name = "GLEAM", desc = "Backend", featured = False }
    , { name = "ELM", desc = "Frontend", featured = False }
    , { name = "NODE.JS", desc = "APIs / Serviços", featured = False }
    , { name = "TYPESCRIPT", desc = "Frontend/Mobile/Deno", featured = False }
    , { name = "REDIS", desc = "Filas / Cache", featured = False }
    , { name = "POSTGRES", desc = "Banco de dados", featured = False }
    , { name = "DOCKER", desc = "Containers", featured = False }
    , { name = "LINUX", desc = "VPS / Deploy", featured = False }
    , { name = "GIT", desc = "Versionamento", featured = False }
    ]


viewStack : Html Msg
viewStack =
    section [ class "section", id "stack" ]
        [ p [ class "section__label" ] [ text "Tecnologias" ]
        , h2 [ class "section__title" ] [ text "Tech Stack" ]
        , div [ class "stack__grid" ]
            (List.map viewStackItem techStack)
        ]


viewStackItem : TechItem -> Html Msg
viewStackItem item =
    div
        [ class
            (if item.featured then
                "stack__item stack__item--featured"

             else
                "stack__item"
            )
        ]
        [ span [ class "stack__item-name" ] [ text item.name ]
        , span [ class "stack__item-desc" ] [ text item.desc ]
        ]



-- PROJECTS


type alias Project =
    { cmd : String
    , title : String
    , desc : String
    , status : ProjectStatus
    , tags : List String
    , link : String
    }


type ProjectStatus
    = Building
    | Ready


projects : List Project
projects =
    [ { cmd = "$ cat bookbrain.py"
      , title = "Bookbrain"
      , desc = "Sistema de recomendação de livros com base nos últimos livros lidos pelo usuário."
      , status = Ready
      , tags = [ "Python", "FastAPI", "HTML", "CSS" ]
      , link = "https://github.com/jotamath/bookbrain"
      }
    , { cmd = "$ ./giosk"
      , title = "Sniffer de portas concorrente"
      , desc = "Engine de reconhecimento ativo e port scanning de alta performance desenvolvido em Go. Utiliza concorrência nativa (worker pools) para mapeamento rápido de portas e extração imediata de metadados de serviços (Banner Grabbing)."
      , status = Ready
      , tags = [ "Go", "Security", "Networking", "Recon" ]
      , link = "https://github.com/jotamath/giosk"
      }
    , { cmd = "$ deno task dev"
      , title = "Storymaker Portfolio"
      , desc = "Portfólio de serviços e orçamentos para cobertura de casamentos. Interface de usuário refatorada em Elm, com interopabilidade via TypeScript e ambiente de execução de backend configurado em Deno."
      , status = Building
      , tags = [ "Elm", "Deno", "TypeScript", "Frontend" ]
      , link = "https://portfolio-rute.vercel.app"
      }
    , { cmd = "$ deno task dev"
      , title = "Vault API"
      , desc = "Cofre pessoal para conhecimento técnico, permitindo salvar comandos, snippets, links e notas com organização por tags, filtros por tipo e busca textual."
      , status = Building
      , tags = [ "Deno", "Hono", "TypeScript", "Deno KV" ]
      , link = "https://github.com/jotamath/vault-api"
      }
    , { cmd = "$ deno task dev"
      , title = "Hookcheck"
      , desc = "Ferramenta para depurar integrações com webhooks, exibindo headers, query params e payloads em tempo real, com suporte a relay e histórico de encaminhamentos."
      , status = Building
      , tags = [ "Deno", "Fresh", "TypeScript", "Deno KV", "SSE" ]
      , link = "https://hookcheck.joma.deno.net/"
      }
    ]


viewProjects : Html Msg
viewProjects =
    section [ class "section", id "work" ]
        [ p [ class "section__label" ] [ text "Projetos" ]
        , h2 [ class "section__title" ] [ text "Trabalhos Recentes" ]
        , div [ class "projects__terminal" ]
            [ div [ class "projects__terminal-bar" ]
                [ span [] []
                , span [] []
                , span [] []
                , span [ class "projects__terminal-bar-path" ] [ text "~/portfolio/projects" ]
                ]
            , div [ class "projects__terminal-body" ]
                (List.map viewProject projects
                    ++ [ p [ class "projects__more" ]
                            [ text "...mais projetos em desenvolvimento no GitHub" ]
                       ]
                )
            ]
        ]


viewProject : Project -> Html Msg
viewProject project =
    a
        [ href project.link
        , target "_blank"
        ]
        [ div [ class "projects__item" ]
            [ p [ class "projects__item-cmd" ] [ text project.cmd ]
            , div [ class "projects__item-header" ]
                [ h3 [ class "projects__item-title" ] [ text project.title ]
                , span
                    [ class
                        (case project.status of
                            Building ->
                                "projects__item-status projects__item-status--building"

                            Ready ->
                                "projects__item-status projects__item-status--ready"
                        )
                    ]
                    [ text
                        (case project.status of
                            Building ->
                                "BUILDING"

                            Ready ->
                                "READY"
                        )
                    ]
                ]
            , p [ class "projects__item-desc" ] [ text project.desc ]
            , div [ class "projects__item-tags" ]
                (List.map (\tag -> span [ class "projects__item-tag" ] [ text tag ]) project.tags)
            ]
        ]



-- CONTACT


viewContact : Html Msg
viewContact =
    section [ class "section", id "contact" ]
        [ p [ class "section__label" ] [ text "Contato" ]
        , h2 [ class "section__title" ] [ text "Bora Conversar?" ]
        , div [ class "contact__grid" ]
            [ a [ href "https://github.com/jotamath", target "_blank", class "contact__card" ]
                [ span [ class "contact__card-label" ] [ text "Código aberto" ]
                , span [ class "contact__card-name" ] [ text "GitHub" ]
                , span [ class "contact__card-arrow" ] [ text "↗" ]
                ]
            , a [ href "https://linkedin.com/jotamath", target "_blank", class "contact__card" ]
                [ span [ class "contact__card-label" ] [ text "Rede profissional" ]
                , span [ class "contact__card-name" ] [ text "LinkedIn" ]
                , span [ class "contact__card-arrow" ] [ text "↗" ]
                ]
            , a [ href "mailto:joaomncosta0@gmail.com", class "contact__card contact__card--dark" ]
                [ span [ class "contact__card-label" ] [ text "Fale diretamente" ]
                , span [ class "contact__card-name" ] [ text "Email" ]
                , span [ class "contact__card-arrow" ] [ text "↗" ]
                ]
            ]
        ]



-- FOOTER


viewFooter : Html Msg
viewFooter =
    footer [ class "footer" ]
        [ div [ class "footer__inner" ]
            [ div [ class "footer__top" ]
                [ h2 [ class "footer__headline" ]
                    [ text "VAMOS"
                    , br [] []
                    , text "CRIAR?"
                    ]
                , div [ class "footer__links" ]
                    [ a [ href "https://github.com/jotamath", target "_blank" ] [ text "GitHub" ]
                    , a [ href "https://linkedin.com/jotamath", target "_blank" ] [ text "LinkedIn" ]
                    , a [ href "mailto:joaomncosta0@gmail.com" ] [ text "Email" ]
                    ]
                ]
            , div [ class "footer__bottom" ]
                [ p [] [ text "© 2026 João Costa — Feito com ❤️." ]
                , div [ class "footer__tech-badge" ]
                    [ span [] [ text "Elm" ]
                    , span [] [ text "SCSS" ]
                    , span [] [ text "Deno" ]
                    ]
                ]
            ]
        ]
