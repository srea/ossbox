#!/bin/sh

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "rsync -rp ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -rp "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      ;;
    *)
      echo "cp -R ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
      cp -R "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
      ;;
  esac
}
install_resource 'AKTabBarController/AKTabBarController/AKTabBarController.bundle'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-addbutton-highlighted.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-addbutton-highlighted@2x.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-addbutton.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-addbutton@2x.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-menuitem-highlighted.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-menuitem-highlighted@2x.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-menuitem.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/bg-menuitem@2x.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/icon-plus-highlighted.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/icon-plus-highlighted@2x.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/icon-plus.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/icon-plus@2x.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/icon-star.png'
install_resource 'AwesomeMenu/AwesomeMenu/Images/icon-star@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blackArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blackArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blueArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blueArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/grayArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/grayArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/whiteArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/whiteArrow@2x.png'
install_resource 'Facebook-iOS-SDK/src/FacebookSDKResources.bundle'
install_resource 'MHTabBarController/Images/MHTabBarActiveTab.png'
install_resource 'MHTabBarController/Images/MHTabBarInactiveTab.png'
install_resource 'MHTabBarController/Images/MHTabBarIndicator.png'
install_resource 'NoticeView/NoticeView/WBNoticeView/NoticeView.bundle'
install_resource 'REComposeViewController/REComposeViewController/REComposeViewController.bundle'
install_resource 'SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle'
install_resource 'SVWebViewController/SVWebViewController/SVWebViewController.bundle'
install_resource 'ShareThis/Assets/Instapaper-Icon.png'
install_resource 'ShareThis/Assets/Instapaper-Icon@2x.png'
install_resource 'ShareThis/Assets/Pocket-Icon.png'
install_resource 'ShareThis/Assets/Pocket-Icon@2x.png'
install_resource 'ShareThis/Assets/Readability-Icon.png'
install_resource 'ShareThis/Assets/Readability-Icon@2x.png'
install_resource 'WEPopover/popoverArrowDown.png'
install_resource 'WEPopover/popoverArrowDown@2x.png'
install_resource 'WEPopover/popoverArrowDownSimple.png'
install_resource 'WEPopover/popoverArrowLeft.png'
install_resource 'WEPopover/popoverArrowLeft@2x.png'
install_resource 'WEPopover/popoverArrowLeftSimple.png'
install_resource 'WEPopover/popoverArrowRight.png'
install_resource 'WEPopover/popoverArrowRight@2x.png'
install_resource 'WEPopover/popoverArrowRightSimple.png'
install_resource 'WEPopover/popoverArrowUp.png'
install_resource 'WEPopover/popoverArrowUp@2x.png'
install_resource 'WEPopover/popoverArrowUpSimple.png'
install_resource 'WEPopover/popoverBg.png'
install_resource 'WEPopover/popoverBg@2x.png'
install_resource 'WEPopover/popoverBgSimple.png'
