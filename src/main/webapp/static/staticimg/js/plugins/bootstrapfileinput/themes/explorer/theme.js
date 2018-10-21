/*!
 * bootstrap-fileinput v4.4.3
 * http://plugins.krajee.com/file-input
 *
 * Krajee Explorer theme configuration for bootstrap-fileinput. Load this theme file after loading `fileinput.js`.
 *
 * Author: Kartik Visweswaran
 * Copyright: 2014 - 2017, Kartik Visweswaran, Krajee.com
 *
 * Licensed under the BSD 3-Clause
 * https://github.com/kartik-v/bootstrap-fileinput/blob/master/LICENSE.md
 */
(function ($) {
    "use strict";
    var teTagBef = '<div class="file-preview-frame {frameClass}" id="{previewId}" data-fileindex="{fileindex}"' +
        ' data-template="{template}"', teContent = '<div class="kv-file-remove phdelbtn" title="View Details"><i class="glyphicon glyphicon-remove-circle"></i></div><div class="kv-file-content">\n';
    $.fn.fileinputThemes.explorer = {
        layoutTemplates: {
            preview: '<div class="file-preview {class}">\n' +
            '    {close}' +
            '    <div class="{dropClass}">\n' +
            '    <table class="table"><tbody class="file-preview-thumbnails">\n' +
            '    </tbody></table>\n' +
            '    <div class="clearfix"></div>' +
            '    <div class="file-preview-status text-center text-success"></div>\n' +
            '    <div class="kv-fileinput-error"></div>\n' +
            '    </div>\n' +
            '</div>',
            footer: '<div class="file-details-cell hide"><div class="explorer-caption" title="{caption}">{caption}</div> ' +
            '{size}{progress}</div><div class="file-actions-cell">{indicator} {actions}</div>',
            actions: '{drag}\n' +
            '<div class="file-actions hide">\n' +
            '    <div class="file-footer-buttons">\n' +
            '        {upload} {delete} {zoom} {other} ' +
            '    </div>\n' +
            '</div>',
            zoomCache: '<div style="display:none" class="kv-zoom-cache"><div>' +
            '<table class="kv-zoom-cache">{zoomContent}</table></div></div>'
        },
        previewMarkupTags: {
            tagBefore1: teTagBef + '>' + teContent,
            tagBefore2: teTagBef + ' title="{caption}">' + teContent,
            tagAfter: '</div>\n{footer}</div>\n'
        },
        previewSettings: {
            image: {width: "65%", height: "auto"},
            html: {width: "100px", height: "60px"},
            text: {width: "100px", height: "60px"},
            video: {width: "auto", height: "60px"},
            audio: {width: "auto", height: "60px"},
            flash: {width: "100%", height: "60px"},
            object: {width: "100%", height: "60px"},
            pdf: {width: "100px", height: "60px"},
            other: {width: "100%", height: "60px"}
        },
        frameClass: 'explorer-frame'
    };
})(window.jQuery);
