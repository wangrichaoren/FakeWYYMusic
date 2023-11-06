cmake_minimum_required(VERSION 3.16)

project(fake_wangyiyun_ui VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QML_IMPORT_PATH D:/Qt6/6.6.0/mingw_64/qml)


find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appfake_wangyiyun_ui
    main.cpp
)

qt_add_qml_module(appfake_wangyiyun_ui
    URI fake_wangyiyun_ui
    VERSION 1.0

    # code
    QML_FILES
    Main.qml
    ViewBtn.qml
    SplitLine.qml
    NormalBtn.qml
    IconBoradBtn.qml
    SearchInputEdite.qml
    RecordControl.qml
    CircleBtn.qml
    ImageNoEffBtn.qml
    VolumeControl.qml
    OpactityBtn.qml
    PopWindow.qml
    MsgPopup.qml
    MySwiperView.qml

    # resource
    RESOURCES
    bg_imgs/background1.jpg
    bg_imgs/background2.jpg
    bg_imgs/background3.jpg

    # win icon
    window_icons/wyyyy.svg
    window_icons/wyyyycircle.svg
    window_icons/face_wwtj.svg
    window_icons/face_yyyjx.svg
    window_icons/face_bk.svg
    window_icons/face_srmy.svg
    window_icons/face_sq.svg
    window_icons/face_wxhdyy.svg
    window_icons/face_zjbf.svg
    window_icons/face_wdbk.svg
    window_icons/face_wdsc.svg
    window_icons/face_xzsl.svg
    window_icons/face_bdyy.svg
    window_icons/face_wdyyyp.svg
    window_icons/window_close.svg
    window_icons/window_max.svg
    window_icons/window_min.svg
    window_icons/window_reset.svg
    window_icons/window_hf.svg
    window_icons/window_set.svg
    window_icons/window_msg.svg
    window_icons/window_mini.svg
    window_icons/window_back.svg
    window_icons/window_tgsq.svg
    window_icons/window_find.svg
    window_icons/window_play.svg
    window_icons/window_pause.svg
    window_icons/window_left.svg
    window_icons/window_right.svg
    window_icons/window_xdms.svg
    window_icons/window_c.svg
    window_icons/window_like.svg
    window_icons/window_pl.svg
    window_icons/window_xz.svg
    window_icons/window_gd.svg
    window_icons/window_vol_on.svg
    window_icons/window_vol_off.svg
    window_icons/window_bflb.svg
    window_icons/window_yx.svg
    window_icons/jorker.svg

    # 音乐
    jda-zjl.mp3

    jay.png

    # swip切换的图片
    swip_imgs/0.jpg
    swip_imgs/1.jpg
    swip_imgs/2.jpg
    swip_imgs/3.jpg
    swip_imgs/4.jpg
    swip_imgs/5.jpg
    swip_imgs/6.jpg
    swip_imgs/7.jpg
    swip_imgs/8.jpg
    swip_imgs/9.jpg
    swip_imgs/10.jpg
    swip_imgs/11.jpg
    swip_imgs/12.jpg


    RESOURCES resource.qrc

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appfake_wangyiyun_ui PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appfake_wangyiyun_ui
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appfake_wangyiyun_ui
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appfake_wangyiyun_ui
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
