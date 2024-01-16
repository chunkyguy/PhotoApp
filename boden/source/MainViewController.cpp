#include <bdn/ui.h>
#include <bdn/ui/yoga.h>

#include "MainViewController.h"
#include "ListViewController.hpp"

using namespace bdn;

MainViewController::MainViewController() : _listViewController(std::make_shared<ListViewController>())
{
    _window = std::make_shared<ui::Window>();
    _window->title = "Demo Boden";
    _window->geometry = Rect{0, 0, 1024, 768};
    _window->setLayout(std::make_shared<ui::yoga::Layout>());
    
    
    auto navigationView = std::make_shared<ui::NavigationView>();
    navigationView->stylesheet = FlexJsonStringify({
        "direction" : "Column",
        "flexGrow" : 1.0,
        "flexShrink" : 1.0,
        "alignItems" : "Stretch"
    });

    navigationView->pushView(_listViewController->view(), "Photo List");

    _window->contentView = navigationView;
    
    _window->visible = true;
}
