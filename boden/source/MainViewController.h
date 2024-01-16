#pragma once

#include <bdn/ui/Window.h>

class ListViewController;

class MainViewController
{
  public:
    MainViewController();
    virtual ~MainViewController() = default;

  private:
    std::shared_ptr<bdn::ui::Window> _window;
    std::shared_ptr<ListViewController> _listViewController;
};
