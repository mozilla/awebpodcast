#!/bin/bash
set -ex

# branch names don't correspond 1:1 with config file names
branch="$1"
case branch in
    --dev)
        SITE="dev"
        ;;
    --master)
        SITE="stage"
        ;;
    --prod)
        SITE="prod"
        ;;
    *)
        SITE=""
        ;;
esac

cd "$(dirname ${BASH_SOURCE[0]})"/..
mkdir -p ./release

if [[ -n $SITE ]]; then
    # let gulp build the assets
    docker run --rm --label=gulp \
        --volume=$(pwd):/srv \
        --entrypoint /bin/bash \
        huli/gulp \
        -c "/entrypoint.sh build --production && chown $(id -u):$(id -g) . -R"

    # and then let hugo build the site
    docker run --rm --label=hugo \
        --volume=$(pwd):/src \
        --volume=$(pwd)/release:/tmp/build \
        -e HUGO_ENV=production \
        jojomi/hugo:0.40.2 \
        ash -c "rm -rf /tmp/build/* && hugo --config config.toml,config-${SITE}.toml --destination /tmp/build"
fi
