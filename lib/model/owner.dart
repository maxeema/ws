
///

enum Owner {
  Me, System, Other
}

extension OwnerExt on Owner {

  bool get me     => this == Owner.Me;
  bool get system => this == Owner.System;
  bool get other  => this == Owner.Other;

}