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
    yyycpcp.png
    background1.jpg
    background2.jpg
    background3.jpg

#    wyyyy.svg
    wyyyycircle.svg
    face_wwtj.svg
    face_yyyjx.svg
    face_bk.svg
    face_srmy.svg
    face_sq.svg
    face_wxhdyy.svg
    face_zjbf.svg
    face_wdbk.svg
    face_wdsc.svg
    face_xzsl.svg
    face_bdyy.svg
    face_wdyyyp.svg
    window_close.svg
    window_max.svg
    window_min.svg
    window_reset.svg
    window_hf.svg
    window_set.svg
    window_msg.svg
    window_mini.svg
    window_back.svg
    window_tgsq.svg
    window_find.svg
    window_play.svg
    window_pause.svg
    window_left.svg
    window_right.svg
    window_xdms.svg
    window_c.svg
    window_like.svg
    window_pl.svg
    window_xz.svg
    window_gd.svg
    window_vol_on.svg
    window_vol_off.svg
    window_bflb.svg
    window_yx.svg

    jorker.svg

    # 音乐
    jda-zjl.mp3

    jay.png
    jay2.png
    0.jpg
    1.jpg
    2.jpg
    3.jpg
    4.jpg
    5.jpg
    6.jpg
    7.jpg
    8.jpg
    9.jpg
    10.jpg
    11.jpg
    12.jpg


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
