//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import "TBCActionSheet.h"

#import <UIKit/UIKit.h>


@interface TBCActionSheet () <UIActionSheetDelegate>
@end

@implementation TBCActionSheet {
@private
    UIActionSheet *_actionSheet;
    NSMutableDictionary *_handlers;
    TBCActionSheet *_retainCycleWhilePresented;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler {
    if ((self = [super init])) {
        _handlers = [[NSMutableDictionary alloc] init];

        UIActionSheet * const actionSheet = _actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil];
        if (cancelButtonTitle) {
            _handlers[@(actionSheet.cancelButtonIndex)] = [cancelButtonHandler?:^{} copy];
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title cancelButtonTitle:nil cancelButtonHandler:nil];
}

- (NSInteger)addButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler {
    NSParameterAssert(title);

    UIActionSheet * const actionSheet = _actionSheet;

    NSInteger const buttonIndex = [actionSheet addButtonWithTitle:title];
    _handlers[@(buttonIndex)] = [(handler ?: ^{}) copy];

    return buttonIndex;
}

- (NSInteger)addCancelButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler {
    NSParameterAssert(title);

    UIActionSheet * const actionSheet = _actionSheet;

    NSInteger const buttonIndex = [actionSheet addButtonWithTitle:title];
    actionSheet.cancelButtonIndex = buttonIndex;

    _handlers[@(buttonIndex)] = [(handler ?: ^{}) copy];

    return buttonIndex;
}

- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler {
    NSParameterAssert(title);

    UIActionSheet * const actionSheet = _actionSheet;

    NSInteger const buttonIndex = [actionSheet addButtonWithTitle:title];
    actionSheet.destructiveButtonIndex = buttonIndex;

    _handlers[@(buttonIndex)] = [(handler ?: ^{}) copy];

    return buttonIndex;
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    _retainCycleWhilePresented = self;
    [_actionSheet showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
    _retainCycleWhilePresented = self;
    [_actionSheet showFromRect:rect inView:view animated:animated];
}

- (void)showFromTabBar:(UITabBar *)view {
    _retainCycleWhilePresented = self;
    [_actionSheet showFromTabBar:view];
}

- (void)showFromToolbar:(UIToolbar *)view {
    _retainCycleWhilePresented = self;
    [_actionSheet showFromToolbar:view];
}

- (void)showInView:(UIView *)view {
    _retainCycleWhilePresented = self;
    [_actionSheet showInView:view];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)index animated:(BOOL)animated {
    [_actionSheet dismissWithClickedButtonIndex:index animated:animated];
}

- (NSString *)title {
    return _actionSheet.title;
}

- (void)setTitle:(NSString *)title {
    _actionSheet.title = title;
}

- (BOOL)isVisible {
    return _actionSheet.visible;
}


#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    dispatch_block_t const handler = _handlers[@(buttonIndex)];
    if (handler) {
        handler();
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _retainCycleWhilePresented = nil;
}

@end
