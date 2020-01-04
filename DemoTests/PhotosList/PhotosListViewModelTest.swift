//
//  PhotosListViewModelTest.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo
import XCTest

class PhotosListViewModelTest: BaseTestCase {
    
    func testConfigurationsWithEmptyList() throws {
        let viewModel = PhotosListViewModel(
            output: PhotosListModuleOutputStub(),
            interactor: PhotosListInteractorStub(scheduler: scheduler)
        )
        let observer = scheduler.createObserver([SectionConfiguration].self)
        viewModel.configurations.subscribe(observer).disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(observer.events.count, 1)
        
        let sections = try XCTUnwrap(observer.events.first?.value.element)
        XCTAssertEqual(sections.count, 0)
        
        XCTAssertEqual(viewModel.emptyListText, "There are no photos yet")
    }
    
    func testConfigurationsWithPhoto() throws {
        let viewModel = PhotosListViewModel(
            output: PhotosListModuleOutputStub(),
            interactor: PhotosListInteractorStub(
                scheduler: scheduler,
                photos: [FakeData.photo1]
            )
        )
        let observer = scheduler.createObserver([SectionConfiguration].self)
        viewModel.configurations.subscribe(observer).disposed(by: disposeBag)
        viewModel.refresh()
        
        scheduler.start()
        
        XCTAssertEqual(observer.events.count, 2)
        
        let firstResult = try XCTUnwrap(observer.events.first?.value.element)
        XCTAssertEqual(firstResult.count, 0)
        
        let secondResult = try XCTUnwrap(observer.events.last?.value.element)
        XCTAssertEqual(secondResult.count, 1)
        
        let section = try XCTUnwrap(secondResult.first)
        XCTAssertEqual(section.rows.count, 1)
        
        let firstCell = try XCTUnwrap(section.rows.first as? PhotoCellConfiguration)
        XCTAssertEqual(firstCell.title, FakeData.photos.first?.title)
    }
    
    func testOpenDetailsWithTwoPhotos() throws {
        let output = PhotosListModuleOutputStub()
        let viewModel = PhotosListViewModel(
            output: output,
            interactor: PhotosListInteractorStub(
                scheduler: scheduler,
                photos: FakeData.photos
            )
        )
        
        let observer = scheduler.createObserver([SectionConfiguration].self)
        viewModel.configurations.subscribe(observer).disposed(by: disposeBag)
        viewModel.refresh()
        
        scheduler.start()
        
        XCTAssertEqual(observer.events.count, 2)
        let sections = try XCTUnwrap(observer.events.last?.value.element)
        XCTAssertEqual(sections.count, 1)
        let section = try XCTUnwrap(sections.first)
        XCTAssertEqual(section.rows.count, 2)
        
        output.onPhotoDetails = { clicked in
            XCTAssertEqual(FakeData.photos.first?.id, clicked.id)
        }
        
        section.clickRow(with: 0)
        
        XCTAssertEqual(output.openDetailsCount, 1)
    }
}
