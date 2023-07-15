pragma Singleton
import QtQuick

Item {
    id: root

    property alias logo             : logo
    property alias arrow            : arrow
    property alias calender         : calender
    property alias camera           : camera
    property alias colorEdit        : colorEdit
    property alias clock            : clock
    property alias component        : component
    property alias document         : document
    property alias eye              : eye
    property alias flag             : flag
    property alias folder           : folder
    property alias home             : home
    property alias key              : key
    property alias magnifier        : magnifier
    property alias media            : media
    property alias note             : note
    property alias notification     : notification
    property alias other            : other
    property alias performance      : performance
    property alias pin              : pin
    property alias system           : system
    property alias templateView     : templateView
    property alias user             : user
    property alias ptz              : ptz
    property alias slider           : slider
    property alias windowsHeader    : windowsHeader


    QtObject {
        id: logo
        readonly property string login_page_logo                : "qrc:/assets/icon/logo/login_page_logo.svg"
    }

    QtObject {
        id: arrow
        readonly property string arrow_down                     : "qrc:/assets/icon/arrow/arrow_down.svg"
        readonly property string arrow_left                     : "qrc:/assets/icon/arrow/arrow_left.svg"
        readonly property string arrow_right                    : "qrc:/assets/icon/arrow/arrow_right.svg"
        readonly property string arrow_up                       : "qrc:/assets/icon/arrow/arrow_up.svg"
        readonly property string down                           : "qrc:/assets/icon/arrow/down.svg"
        readonly property string down_bold                      : "qrc:/assets/icon/arrow/down_bold.svg"
        readonly property string left                           : "qrc:/assets/icon/arrow/left.svg"
        readonly property string left_bold                      : "qrc:/assets/icon/arrow/left_bold.svg"
        readonly property string right                          : "qrc:/assets/icon/arrow/right.svg"
        readonly property string right_bold                     : "qrc:/assets/icon/arrow/right_bold.svg"
        readonly property string scroll                         : "qrc:/assets/icon/arrow/scroll.svg"
        readonly property string up                             : "qrc:/assets/icon/arrow/up.svg"
        readonly property string up_bold                        : "qrc:/assets/icon/arrow/up_bold.svg"
    }

    QtObject {
        id: calender
        readonly property string calender                       : "qrc:/assets/icon/calender/calendar.svg"
        readonly property string calender1                      : "qrc:/assets/icon/calender/calendar_1.svg"
    }

    QtObject {
        id: camera
        readonly property string add_camera                     : "qrc:/assets/icon/camera/add_camera.svg"
        readonly property string add_recordplan                 : "qrc:/assets/icon/camera/add_recordplan.svg"
        readonly property string camera                         : "qrc:/assets/icon/camera/camera.svg"
        readonly property string camera_1                       : "qrc:/assets/icon/camera/camera_1.svg"
        readonly property string camera_2                       : "qrc:/assets/icon/camera/camera_2.svg"
        readonly property string camera_group                   : "qrc:/assets/icon/camera/camera_group.svg"
        readonly property string camera_handi                   : "qrc:/assets/icon/camera/camera_handi.svg"
        readonly property string noting_found_camera            : "qrc:/assets/icon/camera/noting_found_camera.svg"
        readonly property string ptz_camera                     : "qrc:/assets/icon/camera/ptz_camera.svg"
        readonly property string ptz_camera_1                   : "qrc:/assets/icon/camera/ptz_camera_1.svg"
        readonly property string ptz_camera_2                   : "qrc:/assets/icon/camera/ptz_camera_2.svg"
    }

    QtObject {
        id: colorEdit
        readonly property string brightness_low                 : "qrc:/assets/icon/colorEdit/brightness_low.svg"
        readonly property string brightness_mid                 : "qrc:/assets/icon/colorEdit/brightness_mid.svg"
        readonly property string brightness_high                : "qrc:/assets/icon/colorEdit/brightness_high.svg"
        readonly property string contrast_low                   : "qrc:/assets/icon/colorEdit/contrast_low.svg"
        readonly property string contrast_mid                   : "qrc:/assets/icon/colorEdit/contrast_mid.svg"
        readonly property string contrast_high                  : "qrc:/assets/icon/colorEdit/contrast_high.svg"
    }

    QtObject {
        id: clock
        readonly property string add_alarm                      : "qrc:/assets/icon/clock/add_alarm.svg"
        readonly property string add_time                       : "qrc:/assets/icon/clock/add_time.svg"
        readonly property string remove_alarm                   : "qrc:/assets/icon/clock/remove_alarm.svg"
        readonly property string time                           : "qrc:/assets/icon/clock/time.svg"
    }

    QtObject {
        id: component
        readonly property string cpu_1                          : "qrc:/assets/icon/component/cpu_1.svg"
        readonly property string cpu_2                          : "qrc:/assets/icon/component/cpu_2.svg"
        readonly property string monitor                        : "qrc:/assets/icon/component/monitor.svg"
        readonly property string phone                          : "qrc:/assets/icon/component/phone.svg"
        readonly property string printer                        : "qrc:/assets/icon/component/printer.svg"
        readonly property string view                           : "qrc:/assets/icon/component/view.svg"
    }

    QtObject {
        id: document
        readonly property string archive                        : "qrc:/assets/icon/document/archive.svg"
        readonly property string archive_download               : "qrc:/assets/icon/document/archive_download.svg"
        readonly property string archive_export                 : "qrc:/assets/icon/document/archive_export.svg"
    }

    QtObject {
        id: eye
        readonly property string disable_eye                    : "qrc:/assets/icon/eye/disable_eye.svg"
        readonly property string eye                            : "qrc:/assets/icon/eye/eye.svg"
    }

    QtObject {
        id: flag
        readonly property string bookmark                       : "qrc:/assets/icon/flag/bookmark.svg"
        readonly property string bookmark_bold                  : "qrc:/assets/icon/flag/bookmark_bold.svg"
        readonly property string flag                           : "qrc:/assets/icon/flag/flag.svg"
        readonly property string flag_1                         : "qrc:/assets/icon/flag/flag_1.svg"
    }

    QtObject {
        id: folder
        readonly property string add_group                      : "qrc:/assets/icon/folder/add_group.svg"
        readonly property string confirm_doc                    : "qrc:/assets/icon/folder/confirm_doc.svg"
        readonly property string delete_doc                     : "qrc:/assets/icon/folder/delete_doc.svg"
        readonly property string document_download              : "qrc:/assets/icon/folder/document_download.svg"
        readonly property string document_upload                : "qrc:/assets/icon/folder/document_upload.svg"
        readonly property string download                       : "qrc:/assets/icon/folder/download.svg"
        readonly property string group                          : "qrc:/assets/icon/folder/group.svg"
        readonly property string group_1                        : "qrc:/assets/icon/folder/group_1.svg"
        readonly property string move_to_group                  : "qrc:/assets/icon/folder/move_to_group.svg"
        readonly property string remove_group                   : "qrc:/assets/icon/folder/remove_group.svg"
    }

    QtObject {
        id: home
        readonly property string home                           : "qrc:/assets/icon/home/home.svg"
        readonly property string home_1                         : "qrc:/assets/icon/home/home_1.svg"
    }

    QtObject {
        id: key
        readonly property string password                       : "qrc:/assets/icon/key/password.svg"
        readonly property string password_1                     : "qrc:/assets/icon/key/password_1.svg"
        readonly property string password_circle                : "qrc:/assets/icon/key/password_circle.svg"
    }

    QtObject {
        id: magnifier
        readonly property string _1x_zoom                       : "qrc:/assets/icon/magnifier/1x_zoom.svg"
        readonly property string _2x_zoom                       : "qrc:/assets/icon/magnifier/2x_zoom.svg"
        readonly property string _4x_zoom                       : "qrc:/assets/icon/magnifier/4x_zoom.svg"
        readonly property string _8x_zoom                       : "qrc:/assets/icon/magnifier/8x_zoom.svg"
        readonly property string magnifier                      : "qrc:/assets/icon/magnifier/magnifier.svg"
        readonly property string preset                         : "qrc:/assets/icon/magnifier/preset.svg"
        readonly property string zoom_in                        : "qrc:/assets/icon/magnifier/zoom_in.svg"
        readonly property string zoom_out                       : "qrc:/assets/icon/magnifier/zoom_out.svg"
    }

    QtObject {
        id: media
        readonly property string _1_5x                          : "qrc:/assets/icon/media/1.5x.svg"
        readonly property string _15s_back                      : "qrc:/assets/icon/media/15s_back.svg"
        readonly property string _15s_next                      : "qrc:/assets/icon/media/15s_next.svg"
        readonly property string _1x                            : "qrc:/assets/icon/media/1x.svg"
        readonly property string _2x                            : "qrc:/assets/icon/media/2x.svg"
        readonly property string _4x                            : "qrc:/assets/icon/media/4x.svg"
        readonly property string _8x                            : "qrc:/assets/icon/media/8x.svg"
        readonly property string back                           : "qrc:/assets/icon/media/back.svg"
        readonly property string next                           : "qrc:/assets/icon/media/next.svg"
        readonly property string exit_full_screen               : "qrc:/assets/icon/media/exit_full_screen.svg"
        readonly property string full_screen                    : "qrc:/assets/icon/media/full_screen.svg"
        readonly property string headphone                      : "qrc:/assets/icon/media/headphone.svg"
        readonly property string pause                          : "qrc:/assets/icon/media/pause.svg"
        readonly property string pause_circle                   : "qrc:/assets/icon/media/pause_circle.svg"
        readonly property string play                           : "qrc:/assets/icon/media/play.svg"
        readonly property string play_circle                    : "qrc:/assets/icon/media/play_circle.svg"
        readonly property string pop_out                        : "qrc:/assets/icon/media/pop_out.svg"
        readonly property string reload                         : "qrc:/assets/icon/media/reload.svg"
        readonly property string stop                           : "qrc:/assets/icon/media/stop.svg"
        readonly property string taps                           : "qrc:/assets/icon/media/taps.svg"
        readonly property string voice                          : "qrc:/assets/icon/media/voice.svg"
        readonly property string volume_up                      : "qrc:/assets/icon/media/volume_up.svg"
    }

    QtObject {
        id: note
        readonly property string description                    : "qrc:/assets/icon/note/description.svg"
        readonly property string note                           : "qrc:/assets/icon/note/note.svg"
    }

    QtObject {
        id: notification
        readonly property string notification                   : "qrc:/assets/icon/notification/notification.svg"
        readonly property string notification_unread            : "qrc:/assets/icon/notification/notification_unread.svg"
    }

    QtObject {
        id: other
        readonly property string add_storage                    : "qrc:/assets/icon/other/add_storage.svg"
        readonly property string attention                      : "qrc:/assets/icon/other/attention.svg"
        readonly property string cluster                        : "qrc:/assets/icon/other/cluster.svg"
        readonly property string core                           : "qrc:/assets/icon/other/core.svg"
        readonly property string error_light                    : "qrc:/assets/icon/other/error_light.svg"
        readonly property string export_1                       : "qrc:/assets/icon/other/export_1.svg"
        readonly property string export_2                       : "qrc:/assets/icon/other/export_2.svg"
        readonly property string favourite_view                 : "qrc:/assets/icon/other/favourite_view.svg"
        readonly property string hand                           : "qrc:/assets/icon/other/hand.svg"
        readonly property string health                         : "qrc:/assets/icon/other/health.svg"
        readonly property string healthy                        : "qrc:/assets/icon/other/healthy.svg"
        readonly property string lock                           : "qrc:/assets/icon/other/lock.svg"
        readonly property string minus                          : "qrc:/assets/icon/other/minus.svg"
        readonly property string node                           : "qrc:/assets/icon/other/node.svg"
        readonly property string plus                           : "qrc:/assets/icon/other/plus.svg"
        readonly property string preset                         : "qrc:/assets/icon/other/preset.svg"
        readonly property string save                           : "qrc:/assets/icon/other/save.svg"
        readonly property string storage                        : "qrc:/assets/icon/other/storage.svg"
        readonly property string unhealthy                      : "qrc:/assets/icon/other/unhealthy.svg"
        readonly property string checked                        : "qrc:/assets/icon/other/checked.svg"
        readonly property string approve                        : "qrc:/assets/icon/other/approve.svg"
        readonly property string error                          : "qrc:/assets/icon/other/error.svg"
    }

    QtObject {
        id: performance
        readonly property string high_performance               : "qrc:/assets/icon/performance/high_performance.svg"
        readonly property string low_performance                : "qrc:/assets/icon/performance/low_performance.svg"
        readonly property string speedometer                    : "qrc:/assets/icon/performance/speedometer.svg"
    }

    QtObject {
        id: pin
        readonly property string favourit                       : "qrc:/assets/icon/pin/favourit.svg"
        readonly property string favourited                     : "qrc:/assets/icon/pin/favourited.svg"
        readonly property string location_pined                 : "qrc:/assets/icon/pin/location_pined.svg"
        readonly property string pin                            : "qrc:/assets/icon/pin/pin.svg"
        readonly property string pined                          : "qrc:/assets/icon/pin/pined.svg"
    }

    QtObject {
        id: system
        readonly property string add                            : "qrc:/assets/icon/system/add.svg"
        readonly property string carbon_floating_ip             : "qrc:/assets/icon/system/carbon_floating_ip.svg"
        readonly property string close                          : "qrc:/assets/icon/system/close.svg"
        readonly property string close_circle                   : "qrc:/assets/icon/system/close_circle.svg"
        readonly property string copy                           : "qrc:/assets/icon/system/copy.svg"
        readonly property string edit                           : "qrc:/assets/icon/system/edit.svg"
        readonly property string filter_3                       : "qrc:/assets/icon/system/filter_3.svg"
        readonly property string ldap_user                      : "qrc:/assets/icon/system/ldap_user.svg"
        readonly property string link                           : "qrc:/assets/icon/system/link.svg"
        readonly property string log_out                        : "qrc:/assets/icon/system/log_out.svg"
        readonly property string map                            : "qrc:/assets/icon/system/map.svg"
        readonly property string minus                          : "qrc:/assets/icon/system/minus.svg"
        readonly property string more                           : "qrc:/assets/icon/system/more.svg"
        readonly property string more_circle                    : "qrc:/assets/icon/system/more_circle.svg"
        readonly property string open_frame                     : "qrc:/assets/icon/system/open_frame.svg"
        readonly property string ping                           : "qrc:/assets/icon/system/ping.svg"
        readonly property string printer                        : "qrc:/assets/icon/system/printer.svg"
        readonly property string privilage                      : "qrc:/assets/icon/system/privilage.svg"
        readonly property string refresh                        : "qrc:/assets/icon/system/refresh.svg"
        readonly property string setting                        : "qrc:/assets/icon/system/setting.svg"
        readonly property string sitemap                        : "qrc:/assets/icon/system/sitemap.svg"
        readonly property string tick_circle                    : "qrc:/assets/icon/system/tick_circle.svg"
        readonly property string trash                          : "qrc:/assets/icon/system/trash.svg"
    }

    QtObject {
        id: templateView
        readonly property string _2_frame_view                  : "qrc:/assets/icon/templateView/2_frame_view.svg"
        readonly property string _2_frame_view_width            : "qrc:/assets/icon/templateView/2_frame_view_width.svg"
        readonly property string _36_frame_view                 : "qrc:/assets/icon/templateView/36_frame_view.svg"
        readonly property string _3_frame_view                  : "qrc:/assets/icon/templateView/3_frame_view.svg"
        readonly property string _3_frame_view_horizontal       : "qrc:/assets/icon/templateView/3_frame_view_horizontal.svg"
        readonly property string _6_frame_view                  : "qrc:/assets/icon/templateView/6_frame_view.svg"
        readonly property string _9_frame_view                  : "qrc:/assets/icon/templateView/9_frame_view.svg"
        readonly property string variant_8                      : "qrc:/assets/icon/templateView/variant_8.svg"
    }

    QtObject {
        id: user
        readonly property string add_new_user                   : "qrc:/assets/icon/user/add_new_user.svg"
        readonly property string admin_user                     : "qrc:/assets/icon/user/admin_user.svg"
        readonly property string standard_user                  : "qrc:/assets/icon/user/standard_user.svg"
        readonly property string users_group                    : "qrc:/assets/icon/user/users_group.svg"
    }

    QtObject {
        id: ptz
        readonly property string arrow_bottom                   : "qrc:/assets/icon/ptz/arrow_bottom.svg"
        readonly property string arrow_left                     : "qrc:/assets/icon/ptz/arrow_left.svg"
        readonly property string arrow_right                    : "qrc:/assets/icon/ptz/arrow_right.svg"
        readonly property string arrow_top                      : "qrc:/assets/icon/ptz/arrow_top.svg"
        readonly property string joystic_default                : "qrc:/assets/icon/ptz/joystic_default.svg"
        readonly property string joystic_down                   : "qrc:/assets/icon/ptz/joystic_down.svg"
        readonly property string joystic_left                   : "qrc:/assets/icon/ptz/joystic_left.svg"
        readonly property string joystic_right                  : "qrc:/assets/icon/ptz/joystic_right.svg"
        readonly property string joystic_thumb                  : "qrc:/assets/icon/ptz/joystic_thumb.svg"
        readonly property string joystic_up                     : "qrc:/assets/icon/ptz/joystic_up.svg"
    }

    QtObject {
        id: slider
        readonly property string slider_default                 : "qrc:/assets/icon/slider/slider_default.svg"
        readonly property string slider_hover                   : "qrc:/assets/icon/slider/slider_hover.svg"
        readonly property string slider_press                   : "qrc:/assets/icon/slider/slider_press.svg"
        readonly property string focus_high                     : "qrc:/assets/icon/slider/focus_high.svg"
        readonly property string focus_low                      : "qrc:/assets/icon/slider/focus_low.svg"
        readonly property string iris_high                      : "qrc:/assets/icon/slider/iris_high.svg"
        readonly property string iris_low                       : "qrc:/assets/icon/slider/iris_low.svg"
    }

    QtObject {
        id: windowsHeader
        readonly property string close_header                   : "qrc:/assets/icon/windowsControl/close.svg"
        readonly property string maximum_header                 : "qrc:/assets/icon/windowsControl/maximum.svg"
        readonly property string minimize_header                : "qrc:/assets/icon/windowsControl/minimized.svg"
        readonly property string notification_header            : "qrc:/assets/icon/windowsControl/notification.svg"
        readonly property string monitor_header                 : "qrc:/assets/icon/windowsControl/monitoring.svg"
        readonly property string resize_header                  : "qrc:/assets/icon/windowsControl/resize.svg"
        readonly property string export_header                  : "qrc:/assets/icon/windowsControl/export.svg"
    }
}
