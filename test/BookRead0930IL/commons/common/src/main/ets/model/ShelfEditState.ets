/**
 * 书架编辑态共享状态：沉浸光感标题栏位于 NavDestination 原生标题栏，
 * 与书架页面组件不在同一子树，通过 AppStorageV2 共享批量管理态的标题数据与回调。
 * 低版本分支（页面内 NavHeaderBar）不读取本状态，行为保持接入前源程序状态。
 */
@ObservedV2
export class ShelfEditState {
  @Trace selectedCount: number = 0;
  private quitEditCallback: () => void = () => {
  };
  private refreshShelfCallback: () => void = () => {
  };

  registerCallbacks(quitEdit: () => void, refreshShelf: () => void): void {
    this.quitEditCallback = quitEdit;
    this.refreshShelfCallback = refreshShelf;
  }

  quitEdit(): void {
    this.quitEditCallback();
  }

  refreshShelf(): void {
    this.refreshShelfCallback();
  }
}
