xquery version "3.1";

module namespace app="http://exist-db.org/apps/doc5/templates";

declare namespace xqdoc="http://www.xqdoc.org/1.0";
import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/apps/doc5/config" at "config.xqm";

declare namespace db5="http://docbook.org/ns/docbook";

declare variable $app:tickets :="https://github.com/duncdrum/exist-docs/issues/new?title=error%20on%20quickstart";

(: Placeholder and unfinished :)

declare
  %templates:wrap
function app:body($node as node(), $model as map(*)) {
(: not doing anything right now went with JS instead :)
    switch($node/ancestor::html//div[@role="main"]/@id)
      case 'index' return attribute class {'landing-page'}
    default return attribute class {'body-green'}
};

declare function app:fa-icons($node as node(), $model as map(*)) as element(i){
  switch($node)
    case 'Getting Started with Web Application Development'
      return <i class="icon fas fa-paper-plane"/>
    default return <i class="icon icon_puzzle_alt"/>
};

declare
  %templates:wrap
function app:docnav($node as node(), $model as map(*)) as element (div) {
  <div id="doc-nav" class="doc-nav">
      <nav id="doc-menu" class="nav doc-menu flex-column sticky">{
        for $n1 in $node//db5:sect1
        let $n2 := $n1//db5:sect2
        return
            (element a { attribute class {'nav-link'},
                attribute href {'#' || data($n1/@xml:id)},
                $n1/db5:title/text()
            },
            if ($n2)
            then (element nav { attribute class {'doc-sub-menu nav flex-column'},
                for $n in $n2
                return
                element a { attribute class {'nav-link'},
                attribute href {'#' || data($n/@xml:id)},
                $n/db5:title/text()
            }
            })
            else ())
      }</nav>
  <!--//doc-menu-->
  </div>
};

declare
  %templates:wrap
  function app:promo($node as node(), $model as map(*)) as element(div){
    (: might go if no new use case comes up :)
    <div id="promo-block" class="promo-block">
      <div class="container">
        <div class="promo-block-inner">
          <div class="row">
            <div data-template="app:ticket"/>
            <div data-template="app:further-reading"/>
            </div>
            <!-- //row -->
          </div>
          <!-- //promo-inner -->
        </div>
        <!-- //container -->
      </div>
    (:  <!-- //promo-block -->    :)
  };

(: live n hot :)

declare function app:head($node as node(), $model as map(*)) as element(header){

    <header class="header text-center">
        <div class="container">
          <div class="branding">
            <h1 class="logo">
              <img src="resources/images/existdb-logo.png" alt="exist-db" style="height:1em"/>
              <span class="text-bold"> Documentation</span>
            </h1>
          </div>
          <!-- //banding -->
          <div class="tagline">
            <p>Open source native XML database</p>
          </div>
          <!-- //tag-line -->
          <div class="text-right text-info">
          <p>version: {data(config:expath-descriptor()/@version)}</p>
          </div>
          <!-- //version-byline -->
          {
          (: there is probably a better way to find this, but it escapes me right now. :)
          let $uri := tokenize(request:get-uri(), '/')
          let $file := for $token in $uri
            where contains($token, '.')
            return
                substring-before($token, '.')
          return
            if ($file eq "index")
            then (<div class="social-container">
            <div class="twitter-tweet">
              <a href="https://twitter.com/share" class="twitter-share-button" data-text="eXist-db open source native XML database" data-via="existdb">Tweet</a>
              <script>
                <![CDATA[! function(d, s, id) {
                  var js, fjs = d.getElementsByTagName(s)[0],
                    p = /^http:/.test(d.location) ? 'http' : 'https';
                  if (!d.getElementById(id)) {
                    js = d.createElement(s);
                    js.id = id;
                    js.src = p + '://platform.twitter.com/widgets.js';
                    fjs.parentNode.insertBefore(js, fjs);
                  }
                }(document, 'script', 'twitter-wjs');]]>
              </script>
            </div>
            <!-- //twitter-tweet -->
            <div class="hip-chat cta-container">
              <a class="btn btn-primary btn-xs" href="https://www.hipchat.com/invite/300223/6ea0341b23fa1cf8390a23592b4b2c39">
                <i class="fas fa-comments" aria-hidden="true"/> Hip Chat</a>
            </div>
            <!-- //hip-chat -->
          </div>)
            else (<ol class="breadcrumb">
              <li class="breadcrumb-item">
                  <a href="index.html">Home</a>
              </li>
              <li class="breadcrumb-item active">
                <a href="#">{$file}</a>
              </li>
          </ol>)
        }
        </div>
        <!-- //container -->
      </header>

};

declare function app:foot($node as node(), $model as map(*)) as element(footer){
  <footer class="footer text-center">
    <div class="container">
      <!--/* This template is released under the Creative Commons Attribution 3.0 License. Please keep the attribution link below when using for your own project. Thank you for your support. :) If you'd like to use the template without the attribution, you can check out other license options via our website: themes.3rdwavemedia.com */-->
      <small class="copyright">Designed with <i class="fas fa-heart"/> by <a href="https://themes.3rdwavemedia.com/" target="_blank">Xiaoying Riley</a>. Refactored for <a href="https://exist-db.org">exist-db</a> by <a href="https://github.com/duncdrum" target="_blank">Duncan Paterson</a>.</small>
    </div>
    <!-- //container -->
  </footer>
(:  <!-- //footer -->  :)
};

declare
  %templates:wrap
function app:ticket($node as node(), $model as map(*)) as element(div){
  <div class="content-holder col-md-5 col-sm-6 col-xs-12">
    <div class="content-holder-inner">
      <h4 class="content-title">
        <strong>Found a problem with this page?</strong>
      </h4>
      <p>Please submit an issue so we can improve it.</p>
      <a href="{$app:tickets}" class="btn btn-red btn-cta">
        <i class="fas fa-exclamation-circle"/> Submit Issues</a>
    </div>
    <!-- //content-inner -->
  </div>
  (:<!-- //content-holder -->:)
  };

declare
  %templates:wrap
function app:further-reading($node as node(), $model as map(*)) as element(div){
<div class="content-holder col-md-7 col-sm-6 col-xs-12">
  <div class="content-holder-inner">
    <div class="desc">
      <h4 class="content-title">Further Reading</h4>
      <div class="table-responsive">
        <table class="table">
          <thead>
              <tr>
                  <th>Source</th>
                  <th>Link</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>
                      <p class="text-primary">XQuery Specs:</p>
                  </td>
                  <td>Some page</td>
              </tr>
              <tr>
                  <td>
                      <p class="text-primary">The book:</p>
                  </td>
                  <td>Some chapter</td>
              </tr>
              <tr>
                  <td>
                      <p class="text-primary">Wikibooks:</p>
                  </td>
                  <td>another link</td>
              </tr>
          </tbody>
        </table>
      </div>
<!-- //table-responsive -->
    </div>
   <!-- //desc -->
  </div>
 <!-- //content-inner -->
</div>
(:<!-- //content-holder --> :)
};
